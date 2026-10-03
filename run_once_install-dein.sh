#!/bin/zsh
set -eu

[[ -n "${CI:-}" ]] && exit 0

INSTALLATION_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/dein/repos/github.com/Shougo/dein.vim"

if [ -d "$INSTALLATION_DIR" ]; then
	exit 0
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
