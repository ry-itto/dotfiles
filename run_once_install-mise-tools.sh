#!/bin/zsh
set -eu

[[ -n "${CI:-}" ]] && exit 0

if ! command -v mise >/dev/null 2>&1; then
	echo 'mise is not installed yet. Skipping tool install. Run `chezmoi apply` again after `brew bundle --global` finishes.'
	exit 0
fi

mise install
