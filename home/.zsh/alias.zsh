## lsの設定
alias ls='ls -G'
alias l='ls -Gl'
alias la='ls -aGl'

## gitコマンドのエイリアス
alias ga='git add '
alias gc='git commit'
alias gcm='git commit -m '
alias gp='git push origin $(cbn)'
alias gs='git status'
alias gpc='git pull origin $(cbn)'
alias gpu='git pull'
alias gd='git diff'
alias cbn='git symbolic-ref --short HEAD|tr -d \"\\n\"'

## calendar
alias calendar='open https://calendar.google.com'

## vim -> nvim
alias vim='nvim'
