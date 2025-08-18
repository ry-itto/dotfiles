#!/usr/bin/env bats

load test_helper

@test "dotfiles list excludes specified directories" {
    run make -C "${REPO_ROOT}" list
    [ "$status" -eq 0 ]
    
    # Check that excluded directories are not in the list
    ! echo "${output}" | grep -q "\.git/"
    ! echo "${output}" | grep -q "\.github/"
    ! echo "${output}" | grep -q "\.DS_Store"
    ! echo "${output}" | grep -q "\.ruby-version"
    ! echo "${output}" | grep -q "\.config/"
    # .claude should be included (not excluded)
    echo "${output}" | grep -q "\.claude/"
}

@test "dotfiles list includes expected directories" {
    run make -C "${REPO_ROOT}" list
    [ "$status" -eq 0 ]
    
    # Check that expected directories are in the list
    echo "${output}" | grep -q "\.zsh/"
    echo "${output}" | grep -q "\.zshrc"
    echo "${output}" | grep -q "\.tmux.conf"
    echo "${output}" | grep -q "\.gitconfig"
    echo "${output}" | grep -q "\.Brewfile"
}

@test "make install creates symlinks in test HOME" {
    # Run install with test HOME
    run run_make_with_test_home install
    [ "$status" -eq 0 ]
    
    # Check that symlinks are created
    assert_link_exists "${TEST_HOME}/.zshrc"
    assert_link_exists "${TEST_HOME}/.tmux.conf"
    assert_link_exists "${TEST_HOME}/.gitconfig"
    assert_link_exists "${TEST_HOME}/.Brewfile"
    assert_link_exists "${TEST_HOME}/.zsh"
}

@test "make install copies .config directory contents" {
    # Run install with test HOME
    run run_make_with_test_home install
    [ "$status" -eq 0 ]
    
    # Check that .config directory is created and populated
    assert_dir_exists "${TEST_HOME}/.config"
    
    # Check if any config files from repo are copied
    if [[ -d "${REPO_ROOT}/.config" ]] && [[ "$(ls -A "${REPO_ROOT}/.config")" ]]; then
        # Get list of files/dirs in .config
        for item in "${REPO_ROOT}"/.config/*; do
            local basename="$(basename "${item}")"
            if [[ -f "${item}" ]]; then
                assert_file_exists "${TEST_HOME}/.config/${basename}"
            elif [[ -d "${item}" ]]; then
                assert_dir_exists "${TEST_HOME}/.config/${basename}"
            fi
        done
    fi
}

@test "symlinks point to correct targets" {
    # Run install with test HOME
    run run_make_with_test_home install
    [ "$status" -eq 0 ]
    
    # Check that symlinks point to the correct absolute paths
    local dotfiles=$(get_dotfiles_list)
    for dotfile in ${dotfiles}; do
        if [[ -e "${REPO_ROOT}/${dotfile}" ]]; then
            local link="${TEST_HOME}/${dotfile}"
            if [[ -L "${link}" ]]; then
                local target="$(readlink "${link}")"
                local expected="${REPO_ROOT}/${dotfile}"
                [[ "${target}" == "${expected}" ]]
            fi
        fi
    done
}

@test "make install is idempotent" {
    # Run install twice
    run run_make_with_test_home install
    [ "$status" -eq 0 ]
    
    run run_make_with_test_home install
    [ "$status" -eq 0 ]
    
    # Check that symlinks still exist and are correct
    assert_link_exists "${TEST_HOME}/.zshrc"
    assert_link_exists "${TEST_HOME}/.tmux.conf"
}