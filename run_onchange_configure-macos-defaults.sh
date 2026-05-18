#!/bin/zsh
set -eu

[[ -n "${CI:-}" ]] && exit 0

# NSGlobalDomain
# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Key repeat speed
defaults write NSGlobalDomain KeyRepeat -int 2

# Initial key repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles TRUE

# Disable press-and-hold for keys (allows key repeat)
defaults write -g ApplePressAndHoldEnabled -bool false

# Map Caps Lock to Control
defaults write com.apple.keyboard.modifiermapping.1452-640-0 -array-add '{ "HIDKeyboardModifierMappingSrc" = 2; "HIDKeyboardModifierMappingDst" = 4; }'
