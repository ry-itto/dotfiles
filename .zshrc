# 補完
autoload -U compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34
'
# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# 履歴の設定
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups

# cdの設定
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

## lsの設定
alias ls='ls -G'
alias l='ls -Gl'
alias la='ls -aGl'
# 補完候補もLS_COLORSに合わせて色が付くようにする
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

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

# brew 実行時不要なディレクトリのパスが含まれないようにする
# https://qiita.com/takuya0301/items/695f42f6904e979f0152
alias brew='PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin brew'

## vim -> nvim
alias vim='nvim'

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
# プロンプトが表示されるたびに呼ばれる関数
precmd () { vcs_info }
# スタイル設定
zstyle ':vcs_info:*' formats "%F{green}%b%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'

# フローコントロール無効?
setopt no_flow_control

source $ZPLUG_HOME/init.zsh

## 構文バイライト
zplug "zsh-users/zsh-syntax-highlighting"

## cd 強化 with fzf
zplug "b4b4r07/enhancd", use:init.sh
ENHANCD_FILTER=fzf; export ENHANCD_FILTER

## 補完
zplug "zsh-users/zsh-completions"

## Emoji
zplug "b4b4r07/emoji-cli"

## Command 補完
zplug "zsh-users/zsh-autosuggestions"

## prompt
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
SPACESHIP_CHAR_SYMBOL='> '
SPACESHIP_DIR_COLOR=110
SPACESHIP_DIR_TRUNC=0
SPACESHIP_GIT_PREFIX=''
SPACESHIP_GIT_BRANCH_COLOR=green
SPACESHIP_GIT_STATUS_SHOW=false

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# env系init
eval "$(rbenv init -)"
eval "$(pyenv init -)"
eval "$(swiftenv init -)"

# emacs風キーバインドの復活
bindkey -e
