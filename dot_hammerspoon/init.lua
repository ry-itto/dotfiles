-- Hammerspoonの設定リロード用ホットキー: Cmd+Alt+Ctrl+R
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)

-- 設定がリロードされた時の通知
hs.alert.show("Hammerspoon config loaded")