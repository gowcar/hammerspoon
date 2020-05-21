hs.expose.ui.highlightThumbnailStrokeWidth = 8
hs.expose.ui.maxHintLetters = 2
hs.expose.ui.fitWindowsMaxIterations = 30
hs.expose.ui.fitWindowsInBackground = true
expose = hs.expose.new(nil,{showThumbnails=true})
hs.hotkey.bind('ctrl-cmd','e','Expose',function()expose:toggleShow()end)
hs.hotkey.bind('ctrl-cmd-shift','e','App Expose',function()expose_app:toggleShow()end)

