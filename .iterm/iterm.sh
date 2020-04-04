SCRIPT_DIR=$(cd $(dirname $0); pwd)

# iTerm 環境設定ファイルを設定
defaults write com.googlecode.iterm2 PrefsCustomFolder $SCRIPT_DIR
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
