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

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose
