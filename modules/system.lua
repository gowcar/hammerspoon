hs.hotkey.bind(hyperCtrl, "L", function()
  -- caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)

function bindApp(entry)
    hs.hotkey.bind(hyperCtrl, entry.shortcut, entry.appname, function()
        hs.application.launchOrFocus(entry.appname)
        -- toggle_application(applist[i].appname)
    end)
end

bindApp({shortcut = 'P',appname = 'System Preferences'})

