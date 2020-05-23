bind(hyper, 'F', "全屏", function() 
  hs.window.focusedWindow():toggleFullScreen()
end)

bind(hyper, 'C', "窗口居中", function() 
    toggle_window(function() 
      local curWin = hs.window.focusedWindow()
      local curWinFrame = curWin:frame()
      local maxFrame = curWin:screen():frame()

      curWinFrame.w = maxFrame.w * 0.88
      curWinFrame.h = maxFrame.h * 0.88 
      curWinFrame.x = maxFrame.x + (maxFrame.w - curWinFrame.w)/2
      curWinFrame.y = maxFrame.y + (maxFrame.h - curWinFrame.h)/2

			curWin:setFrame(curWinFrame)
    -- local curWin = hs.window.focusedWindow()
    -- curWin:moveToUnit(hs.geometry.rect(20, 20, 0.8, 0.85))
    -- local maxFrame = curWin:screen():frame()
    -- curWin:setSize(maxFrame.w, maxFrame.h)
    -- curWin:centerOnScreen() 
    end)
end)

bind(hyper, 'M', "窗口最大化", function() 
    toggle_window(function() hs.window.focusedWindow():maximize() end)
end)

bind(hyper, "I", "将窗口左移一屏", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest(false, true, 0)
  frameCache[win:id()] = nil
end)

bind(hyper, "O", "将窗口右移一屏", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenEast(false, true, 0)
  frameCache[win:id()] = nil
end)


bind(hyper, "H", "拉宽窗口", function()
  zoomW(1.25);
end)

bind(hyper, "L", "收缩窗口", function()
  zoomW(0.75);
end)

bind(hyper, "J", "压小窗口", function()
  zoomH(0.75);
end)

bind(hyper, "K", "拉高窗口", function()
  zoomH(1.25);
end)

bind({"cmd"}, "escape", "切换任务", function()
  hs.window.switcher.nextWindow()
end)

bind({"cmd", "shift"}, "escape", "反向切换任务", function()
  hs.window.switcher.previousWindow()
end)

local switchers = {}
bind({"alt"}, "escape", "应用内切换窗口", function()
  local win = hs.window.focusedWindow():application():name()
  if not switchers[win] then
    switchers[win] = hs.window.switcher.new({win})
  end
  switchers[win]:next()
end)

bind({"alt", "shift"}, "escape", "应用内反向切换窗口", function()
  local win = hs.window.focusedWindow():application():name()
  if not switchers[win] then
    switchers[win] = hs.window.switcher.new({win})
  end
  switchers[win]:previous()
end)

bind(hyper, "S", "锁屏", function()
  -- caffeinate.lockScreen()
  hs.caffeinate.startScreensaver()
end)

bind(hyper, "P", "系统偏好设置", function()
  hs.application.launchOrFocus('System Preferences')
end)

bind(hyper, "V", "MacVim", function()
  hs.application.launchOrFocus('MacVim')
end)
