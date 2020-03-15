setopt IGNOREEOF

# コマンドミスを修正
setopt correct

# ビープ音を鳴らさない
setopt nobeep
setopt nolistbeep


path=(
  /usr/local/bin(N-/)
  $path
)

## gitのリポジトリ情報をプロンプトに表示する
autoload -U vcs_info

# 文字コードをUTF-8に設定
export LANG=ja_JP.UTF-8

# lsコマンドの色の設定
export LSCOLORS=exfxcxdxbxGxDxabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# エディタなどの設定
export EDITOR=vi
export PAGER='less'

# GO env
GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# python env
CFLAGS="-I$(brew --prefix readline)/include -I$(brew --prefix openssl)/include -I$(xcrun --show-sdk-path)/usr/include"
LDFLAGS="-L$(brew --prefix readline)/lib -L$(brew --prefix openssl)/lib"
PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2

# flutter sdk
export PATH=$PATH:$HOME/Applications/flutter/bin

# mysql path
export PATH=$PATH:/usr/local/mysql/bin

# cargo(rust)
export PATH=$PATH:$HOME/.cargo/env
export PATH="$HOME/.cargo/bin:$PATH"

## SDK類
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$HOME/.rbenv/bin:$PATH
export PATH=$HOME/.pyenv/bin:$PATH

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug

# zsh bin
export PATH=$PATH:$HOME/.zsh/bin
