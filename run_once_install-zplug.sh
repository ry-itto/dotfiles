#!/bin/zsh
set -eu

[[ -n "${CI:-}" ]] && exit 0

if [ ! -d "${ZPLUG_HOME:-$HOME/.zplug}" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
