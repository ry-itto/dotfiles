# Xcode 上でビルド時間を表示する
defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES

# コア数を取得
cores=`system_profiler SPHardwareDataType | grep -o 'Cores:\s\d' | sed -e 's/[^0-9]//g'`
defaults write com.apple.dt.Xcode IDEBuildOperationMaxNumberOfConcurrentCompileTasks $cores
