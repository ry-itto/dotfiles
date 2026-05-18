#!/bin/zsh
set -eu

[[ -n "${CI:-}" ]] && exit 0

INSTALLATION_DIR="$HOME/.cache/dein"

if [ -d "$INSTALLATION_DIR" ]; then
	exit 0
fi

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"
