#!/usr/bin/env bash

export TEST_TEMP_DIR="$(mktemp -d)"
export REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export ORIGINAL_HOME="${HOME}"
export TEST_HOME="${TEST_TEMP_DIR}/home"

setup() {
    mkdir -p "${TEST_HOME}"
    mkdir -p "${TEST_HOME}/.config"
}

teardown() {
    if [[ -d "${TEST_TEMP_DIR}" ]]; then
        rm -rf "${TEST_TEMP_DIR}"
    fi
}

assert_link_exists() {
    local link_path="$1"
    local target_path="$2"
    
    if [[ ! -L "${link_path}" ]]; then
        echo "Expected symlink at ${link_path} does not exist"
        return 1
    fi
    
    if [[ -n "${target_path}" ]]; then
        local actual_target="$(readlink "${link_path}")"
        if [[ "${actual_target}" != "${target_path}" ]]; then
            echo "Symlink ${link_path} points to ${actual_target}, expected ${target_path}"
            return 1
        fi
    fi
}

assert_file_exists() {
    local file_path="$1"
    
    if [[ ! -f "${file_path}" ]]; then
        echo "Expected file at ${file_path} does not exist"
        return 1
    fi
}

assert_dir_exists() {
    local dir_path="$1"
    
    if [[ ! -d "${dir_path}" ]]; then
        echo "Expected directory at ${dir_path} does not exist"
        return 1
    fi
}

run_make_with_test_home() {
    local target="$1"
    HOME="${TEST_HOME}" make -C "${REPO_ROOT}" "${target}"
}

get_dotfiles_list() {
    cd "${REPO_ROOT}" || exit 1
    local candidates=$(find . -maxdepth 1 -name ".*" -type f -o -name ".*" -type d | grep -v "^\.$" | sed 's|^\./||')
    local exclusions=".DS_Store .git .config .ruby-version .github .claude"
    
    for candidate in ${candidates}; do
        local excluded=false
        for exclusion in ${exclusions}; do
            if [[ "${candidate}" == "${exclusion}" ]]; then
                excluded=true
                break
            fi
        done
        if [[ "${excluded}" == "false" ]]; then
            echo "${candidate}"
        fi
    done
}