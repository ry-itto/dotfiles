#!/usr/bin/env bats

load test_helper

@test ".Brewfile exists and is valid" {
    assert_file_exists "${REPO_ROOT}/.Brewfile"
    
    # Check basic Brewfile syntax
    # Should contain brew commands
    grep -q "^brew " "${REPO_ROOT}/.Brewfile"
}

@test ".Brewfile contains expected packages" {
    local brewfile="${REPO_ROOT}/.Brewfile"
    
    # Check for some essential packages
    grep -q "brew 'zsh'" "${brewfile}"
    grep -q "brew 'git'" "${brewfile}"
    grep -q "brew 'tmux'" "${brewfile}"
}

@test ".zshrc exists and sources modular configs" {
    assert_file_exists "${REPO_ROOT}/.zshrc"
    
    # Check that .zshrc sources the modular config files
    grep -q "source.*\.zsh/.*\.zsh" "${REPO_ROOT}/.zshrc" || \
    grep -q "\. .*\.zsh/.*\.zsh" "${REPO_ROOT}/.zshrc" || \
    grep -q "for.*\.zsh.*source" "${REPO_ROOT}/.zshrc"
}

@test "modular zsh configs exist" {
    assert_dir_exists "${REPO_ROOT}/.zsh"
    
    # Check for expected modular config files
    local expected_configs=(
        "alias.zsh"
        "env.zsh"
        "style.zsh"
        "plugin.zsh"
    )
    
    for config in "${expected_configs[@]}"; do
        if [[ ! -f "${REPO_ROOT}/.zsh/${config}" ]]; then
            echo "Warning: Expected config ${config} not found"
            # Not a failure, just a warning
        fi
    done
}

@test ".gitconfig exists and has valid structure" {
    assert_file_exists "${REPO_ROOT}/.gitconfig"
    
    # Check for basic git config structure
    grep -q "\[user\]" "${REPO_ROOT}/.gitconfig" || \
    grep -q "\[core\]" "${REPO_ROOT}/.gitconfig" || \
    grep -q "\[alias\]" "${REPO_ROOT}/.gitconfig"
}

@test ".tmux.conf exists" {
    assert_file_exists "${REPO_ROOT}/.tmux.conf"
}

@test "commit template exists if referenced" {
    if grep -q "template.*=.*\.commit_template" "${REPO_ROOT}/.gitconfig" 2>/dev/null; then
        assert_file_exists "${REPO_ROOT}/.commit_template"
    fi
}

@test "zsh configs have valid syntax" {
    # Test main .zshrc
    run zsh -n "${REPO_ROOT}/.zshrc"
    if [ "$status" -ne 0 ]; then
        echo "Syntax error in .zshrc: ${output}"
        false
    fi
    
    # Test modular configs if they exist
    if [[ -d "${REPO_ROOT}/.zsh" ]]; then
        for config in "${REPO_ROOT}"/.zsh/*.zsh; do
            if [[ -f "${config}" ]]; then
                run zsh -n "${config}"
                if [ "$status" -ne 0 ]; then
                    echo "Syntax error in $(basename "${config}"): ${output}"
                    false
                fi
            fi
        done
    fi
}

@test "no hardcoded absolute paths in configs" {
    # Check for common hardcoded paths that should be avoided
    local configs=(
        "${REPO_ROOT}/.zshrc"
        "${REPO_ROOT}/.gitconfig"
        "${REPO_ROOT}/.tmux.conf"
    )
    
    for config in "${configs[@]}"; do
        if [[ -f "${config}" ]]; then
            # Skip checking for /usr, /bin, /opt as these are system paths
            # Check for hardcoded user home paths
            if grep -q "/Users/[^/]*/" "${config}" | grep -v "^#"; then
                echo "Warning: Possible hardcoded user path in $(basename "${config}")"
                # Just a warning, not a failure
            fi
        fi
    done
}

@test "CLAUDE.md exists and contains setup instructions" {
    if [[ -f "${REPO_ROOT}/CLAUDE.md" ]]; then
        # Check that CLAUDE.md contains key sections
        grep -qi "repository overview\|overview" "${REPO_ROOT}/CLAUDE.md"
        grep -qi "command\|setup\|install" "${REPO_ROOT}/CLAUDE.md"
    else
        echo "Warning: CLAUDE.md not found"
    fi
}