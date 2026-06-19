# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
    _fzf_git_each_ref --no-multi | xargs git checkout
}
