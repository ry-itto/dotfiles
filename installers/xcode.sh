if ! type "xcodebuild" > /dev/null ; then
	xcodes install --latest
fi

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Xcode 上でビルド時間を表示する
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# コア数を取得
cores=`system_profiler SPHardwareDataType | grep -o 'Cores:\s\d' | sed -e 's/[^0-9]//g'`
# アプリをビルドする時に並列でビルドする
defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks $cores
# Including whitespace-only lines 空白しかない行の空白を削除
defaults write com.apple.dt.Xcode DVTTextEditorTrimWhitespaceOnlyLines -bool true
