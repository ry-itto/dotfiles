-- WezTermの表示/非表示を切り替える関数
local open_wezterm = function()
    local appName = "WezTerm"
    local app = hs.application.get(appName)

    if app == nil or app:isHidden() or not(app:isFrontmost()) then
        -- アプリが起動していない、隠れている、または最前面でない場合は表示
        hs.application.launchOrFocus(appName)
    else
        -- アプリが最前面にある場合は隠す
        app:hide()
    end
end

-- ホットキーの設定: Alt+Space (Option+Space) でWezTermの表示/非表示を切り替え
-- tmux.confのプレフィックスキー（Ctrl+q）と競合しないように設定
hs.hotkey.bind({"alt"}, "space", open_wezterm)

-- Hammerspoonの設定リロード用ホットキー: Cmd+Alt+Ctrl+R
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
    hs.reload()
end)

-- 設定がリロードされた時の通知
hs.alert.show("Hammerspoon config loaded")