h() {
    gh repo view -w
}

pr_checkout() {
    gh pr list | fzf | awk '{print $1}' | xargs gh pr checkout 
}

