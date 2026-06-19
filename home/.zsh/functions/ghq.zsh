ghq-cd() {
    local dir="$(ghq list --full-path | fzf)"
    if [ -z "$dir" ]; then
        echo "no directroies found for '$1'"
        return 1
    fi
    cd "$dir"
    return
}
