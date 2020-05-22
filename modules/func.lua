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

function bind(mod, key, msg, action_fn)
  if showMessage then
    hs.hotkey.bind(mod, key, msg, action_fn)
  else
    hs.hotkey.bind(mod, key, action_fn)
  end
end

