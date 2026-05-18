wtp-cd() {
    local dir="$(wtp list -q -c | awk '!/worktree|..\//' | fzf)"
    if [ -z "$dir" ]
    then
        echo "no directories found for $1"
        return 1
    fi

    wtp cd "$dir"
    return
}
