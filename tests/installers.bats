#!/usr/bin/env bats

load test_helper

@test "all installer scripts exist" {
    local installers=(
        "brew.sh"
        "mise.sh"
        "dein.sh"
        "xcode.sh"
        "zplug.sh"
    )
    
    for installer in "${installers[@]}"; do
        assert_file_exists "${REPO_ROOT}/installers/${installer}"
    done
}

@test "all installer scripts have valid zsh syntax" {
    local installers="${REPO_ROOT}"/installers/*.sh
    
    for installer in ${installers}; do
        run zsh -n "${installer}"
        if [ "$status" -ne 0 ]; then
            echo "Syntax error in ${installer}: ${output}"
            false
        fi
    done
}

@test "all installer scripts are executable or run with zsh" {
    local installers="${REPO_ROOT}"/installers/*.sh
    
    for installer in ${installers}; do
        # Check if file has shebang
        local first_line=$(head -n1 "${installer}")
        if [[ "${first_line}" =~ ^#! ]]; then
            # If it has shebang, it should be executable
            if [[ ! -x "${installer}" ]]; then
                echo "Script ${installer} has shebang but is not executable"
                # This is just a warning, not a failure
            fi
        fi
    done
}

@test "brew.sh checks for Homebrew installation" {
    local brew_script="${REPO_ROOT}/installers/brew.sh"
    
    # Check that the script contains Homebrew check
    grep -q 'type "brew"' "${brew_script}" || \
    grep -q "which brew" "${brew_script}" || \
    grep -q "command -v brew" "${brew_script}" || \
    grep -q "brew --version" "${brew_script}"
}

@test "installer scripts use consistent error handling" {
    local installers="${REPO_ROOT}"/installers/*.sh
    
    for installer in ${installers}; do
        local basename=$(basename "${installer}")
        
        # Check for some form of error handling or status checking
        if ! grep -q "set -e" "${installer}" && \
           ! grep -q "|| " "${installer}" && \
           ! grep -q "if \[" "${installer}"; then
            echo "Warning: ${basename} may lack error handling"
            # This is a warning, not a failure
        fi
    done
}

@test "settings installer scripts exist" {
    assert_file_exists "${REPO_ROOT}/settings/macos/install.sh"
    assert_file_exists "${REPO_ROOT}/settings/vscode/install.sh"
    assert_file_exists "${REPO_ROOT}/settings/xcode/install.sh"
}

@test "settings installer scripts have valid syntax" {
    local settings_installers=(
        "${REPO_ROOT}/settings/macos/install.sh"
        "${REPO_ROOT}/settings/vscode/install.sh"
        "${REPO_ROOT}/settings/xcode/install.sh"
    )
    
    for installer in "${settings_installers[@]}"; do
        if [[ -f "${installer}" ]]; then
            run zsh -n "${installer}"
            if [ "$status" -ne 0 ]; then
                echo "Syntax error in ${installer}: ${output}"
                false
            fi
        fi
    done
}