hs.hotkey.bind(hyperAlt, "L", function()
  -- caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)

function bindApp(entry)
    hs.hotkey.bind(hyper, entry.shortcut, entry.appname, function()
        hs.application.launchOrFocus(entry.appname)
        -- toggle_application(applist[i].appname)
    end)
end

bindApp({shortcut = 'P',appname = 'System Preferences'})
bindApp({shortcut = 'V',appname = 'MacVim'})

