ghq-cd() {
    local dir="$(ghq list --full-path | fzf)"
    if [[ -z "$dir" ]]; then
        echo "no directories found" >&2
        return 1
    fi
    cd "$dir"
}
