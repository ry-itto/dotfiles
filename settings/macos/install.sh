# NSGlobalDomain
# 全ての拡張子のファイルを表示
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# キーのリピート速度
defaults write NSGlobalDomain KeyRepeat -int 2

# キーのリピートまでの速度
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# Finderで隠しファイルを表示
defaults write com.apple.finder AppleShowAllFiles TRUE

# キーの押し込み時連続入力をさせる
defaults write -g ApplePressAndHoldEnabled -bool false

# Caps LockキーをControlキーとして使用
defaults write com.apple.keyboard.modifiermapping.1452-640-0 -array-add '{ "HIDKeyboardModifierMappingSrc" = 2; "HIDKeyboardModifierMappingDst" = 4; }'
