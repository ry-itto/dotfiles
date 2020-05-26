SCRIPT_DIR=$HOME/.iterm

# iTerm 環境設定ファイルを設定
defaults write com.googlecode.iterm2 PrefsCustomFolder $SCRIPT_DIR
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
