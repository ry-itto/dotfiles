wtp-cd() {
    local dir="$(wtp list -q -c | awk '!/worktree|..\//' | fzf)"
    if [[ -z "$dir" ]]; then
        echo "no directories found" >&2
        return 1
    fi
    wtp cd "$dir"
}
