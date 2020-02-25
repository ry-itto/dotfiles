SCRIPT_DIR=$(cd $(dirname $0); pwd)

# Xcode 上でビルド時間を表示する
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# コア数を取得
cores=`system_profiler SPHardwareDataType | grep -o 'Cores:\s\d' | sed -e 's/[^0-9]//g'`
# アプリをビルドする時に並列でビルドする
defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks $cores

# カラーテーマを追加
echo 'add color themes...'
cp $SCRIPT_DIR/xcode/themes/* ~/Library/Developer/Xcode/UserData/FontAndColorThemes
