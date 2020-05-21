local frameCache = {}
function toggle_window(action)
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        -- win = hs.window.focusedWindow()
        frameCache[win:id()] = win:frame()
        action()
    end
end

function zoomW(v) 
      local curWin = hs.window.focusedWindow()
      local curWinFrame = curWin:frame()
      local maxFrame = curWin:screen():frame()

      local origin = curWinFrame.w
      local min = maxFrame.w * 0.3
      local max = maxFrame.w 

      local newVal  = curWinFrame.w * v
      local newX = curWinFrame.x + (origin - newVal)/2

      if newVal <= min then
        newVal = min
      elseif newVal >= max then
        newVal = max 
        newX = maxFrame.x
      end

      if math.abs(origin - newVal) > 3 then
          curWinFrame.w = newVal
          curWinFrame.x = newX
          curWin:setFrame(curWinFrame)
      end
end

function zoomH(v) 
      local curWin = hs.window.focusedWindow()
      local curWinFrame = curWin:frame()
      local maxFrame = curWin:screen():frame()

      local origin = curWinFrame.h
      local min = maxFrame.h * 0.3
      local max = maxFrame.h 

      local newVal  = curWinFrame.h * v
      local newY = curWinFrame.y + (origin - newVal)/2

      if newVal <= min then
        newVal = min
      elseif newVal >= max then
        newVal = max 
        newY = maxFrame.y
      end

      if math.abs(origin - newVal) > 3 then
          curWinFrame.h = newVal
          curWinFrame.y = newY
          curWin:setFrame(curWinFrame)
      end
end

-------------以下是快捷键定义------------------
-- 快捷打开
-- ⌃⌥L: 进入屏幕保护
-- ⌘⌃P: 打开System Preferences
-- ⌘⌃V: 打开MacVim

-- 窗口管理
-- ⌘⌃F: [toggle]窗口全屏
-- ⌘⌃C: [toggle]将当前窗口放在屏幕中央，且高度和宽度调整为屏幕的88%
-- ⌘⌃M: [toggle]将当前窗口最大化
-- ⌘⌃H: 增加窗口宽度（25%-50%-75%-100%） 
-- ⌘⌃L: 减少窗口宽度（100%-75%-50%-25%）
-- ⌘⌃J: 减少窗口高度（100%-75%-50%-25%）
-- ⌘⌃K: 增加窗口高度（25%-50%-75%-100%） 
-- ⌘⌃U: 将当前窗口移到左边一个屏幕
-- ⌘⌃I: 将当前窗口移到右边一个屏幕
-- ⌘⌃N: 切换下一个窗口
-- ⌘⌃B: 切换上一个窗口
-- ⌘⌃E: 平铺所有窗口，然后按快捷键立即跳入某个窗口

hs.hotkey.bind(hyper, 'F', function() 
  hs.window.focusedWindow():toggleFullScreen()
end)

hs.hotkey.bind(hyper, 'C', function() 
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

hs.hotkey.bind(hyper, 'M', function() 
    toggle_window(function() hs.window.focusedWindow():maximize() end)
end)

hs.hotkey.bind(hyper, "U", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest(false, true, 0.2)
  frameCache[win:id()] = nil
end)

hs.hotkey.bind(hyper, "I", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenEast(false, true, 0.2)
  frameCache[win:id()] = nil
end)


hs.hotkey.bind(hyper, "H", function()
  zoomW(1.25);
end)

hs.hotkey.bind(hyper, "L", function()
  zoomW(0.75);
end)

hs.hotkey.bind(hyper, "J", function()
  zoomH(0.75);
end)

hs.hotkey.bind(hyper, "K", function()
  zoomH(1.25);
end)

hs.hotkey.bind(hyper, "N", function()
  hs.window.switcher.nextWindow()
  -- hs.window.focusWindowEast() 
  -- hs.grid.toggleShow()
  -- hs.window.highlight.toggleIsolate()
end)

hs.hotkey.bind(hyper, "B", function()
  hs.window.switcher.previousWindow()
end)

local switchers = {}
hs.hotkey.bind(hyperAlt, "N", function()
  local win = hs.window.focusedWindow():application():name()
  if not switchers[win] then
    switchers[win] = hs.window.switcher.new({win})
  end
  switchers[win]:next()
end)

hs.hotkey.bind(hyperAlt, "B", function()
  local win = hs.window.focusedWindow():application():name()
  if not switchers[win] then
    switchers[win] = hs.window.switcher.new({win})
  end
  switchers[win]:previous()
end)

