#! /bin/zsh

# 補完
autoload -U compinit
compinit

path=(
  /usr/local/bin(N-/)
  $path
)

# 定義関数読み込み
source $HOME/.zsh/functions/functions.zsh

# 文字コードをUTF-8に設定
export LANG=ja_JP.UTF-8

# lsコマンドの色の設定
export LSCOLORS=exfxcxdxbxGxDxabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# エディタなどの設定
export EDITOR=vi
export PAGER='less'

# brew
if [ `uname -m` = "arm64" ]; then
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# GO env
GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# python env
CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include"
LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib"
PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2

# mysql path
export PATH=$PATH:/usr/local/mysql/bin

# cargo(rust)
export PATH=$PATH:$HOME/.cargo/env
export PATH=$PATH:$HOME/.cargo/bin

## SDK類
export PATH=$PATH:$HOME/.nodebrew/current/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/.pyenv/bin

# zplug
export ZPLUG_HOME=$HOME/.zplug

# zsh bin
export PATH=$PATH:$HOME/.zsh/bin

# Pub
export PATH="$PATH":"$HOME/.pub-cache/bin"

# fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

# nest
export PATH="$PATH:$HOME/.nest/bin"

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# brew
if [ `uname -m` = "arm64" ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi

# Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"

# Android platform tools
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# 履歴の設定
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000
setopt hist_ignore_dups

setopt IGNOREEOF

# コマンドミスを修正
setopt correct 
# ビープ音を鳴らさない
setopt nobeep
setopt nolistbeep

# cdの設定
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# フローコントロール無効?
setopt no_flow_control

# env系init
source "/$HOME/.sdkman/bin/sdkman-init.sh"

# mise
eval "$(~/.local/bin/mise activate zsh)"
export PATH="$HOME/.local/bin:$PATH"

# flutter sdk
export FLUTTER_ROOT="$(mise where flutter 2>/dev/null || echo '')"
export PATH="$PATH:$HOME/fvm/default/bin"

# emacs風キーバインドの復活
bindkey -e

# Android environment variables
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

export N_PREFIX=$HOME/.n
export PATH="$PATH:$N_PREFIX/bin"

eval "$(wt shell-init)"
export WT_WORKTREE_DIR=.worktree
