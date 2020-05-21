hs.window.animationDuration = 0
previousFrameSizes = {}

function isAlmostEqualToCurWinFrame(geo)
	local epsilon = 5
	local curWin = hs.window.focusedWindow()
	local curWinFrame = curWin:frame()
	if math.abs(curWinFrame.x - geo.x) < epsilon and
		math.abs(curWinFrame.y - geo.y) < epsilon and
		math.abs(curWinFrame.w - geo.w) < epsilon and
		math.abs(curWinFrame.h - geo.h) < epsilon then
		return true
	else
		return false
	end
end

function getMaxWinFrame()
	local curWin = hs.window.focusedWindow()
	return curWin:screen():frame()
end

function getFillLeftWinFrame()
	local curWin = hs.window.focusedWindow()
	local curWinFrame = curWin:frame()
	local maxFrame = curWin:screen():frame()
	curWinFrame.x = maxFrame.x
	curWinFrame.y = maxFrame.y
	curWinFrame.w = maxFrame.w / 2 - 10
	curWinFrame.h = maxFrame.h
	return curWinFrame
end

function getFillRightWinFrame()
	local curWin = hs.window.focusedWindow()
	local curWinFrame = curWin:frame()
	local maxFrame = curWin:screen():frame()
	curWinFrame.x = maxFrame.x + maxFrame.w / 2 + 10
	curWinFrame.y = maxFrame.y
	curWinFrame.w = maxFrame.w / 2 - 10
	curWinFrame.h = maxFrame.h
	return curWinFrame
end

function getFillTopWinFrame()
	local curWin = hs.window.focusedWindow()
	local curWinFrame = curWin:frame()
	local maxFrame = curWin:screen():frame()
	curWinFrame.x = maxFrame.x
	curWinFrame.y = maxFrame.y
	curWinFrame.w = maxFrame.w
	curWinFrame.h = maxFrame.h / 2 - 10
	return curWinFrame
end

function getFillBottomWinFrame()
	local curWin = hs.window.focusedWindow()
	local curWinFrame = curWin:frame()
	local maxFrame = curWin:screen():frame()
	curWinFrame.x = maxFrame.x 
	curWinFrame.y = maxFrame.y + maxFrame.h / 2 + 10
	curWinFrame.w = maxFrame.w
	curWinFrame.h = maxFrame.h / 2 - 10
	return curWinFrame
end


function isPredefinedWinFrameSize()
	if isAlmostEqualToCurWinFrame(getMaxWinFrame()) or
		isAlmostEqualToCurWinFrame(getFillLeftWinFrame()) or
		isAlmostEqualToCurWinFrame(getFillTopWinFrame()) or
		isAlmostEqualToCurWinFrame(getFillBottomWinFrame()) or
		isAlmostEqualToCurWinFrame(getFillRightWinFrame()) then
		return true
	else
		return false
	end
end

function bindResizeAndRestoreToKeys(key, resize_frame_fn)
	hs.hotkey.bind(hyper, key, function()
		local curWin = hs.window.focusedWindow()
		local curWinFrame = curWin:frame()
		local targetFrame = resize_frame_fn()

		if isPredefinedWinFrameSize() and not isAlmostEqualToCurWinFrame(targetFrame) then
			curWin:setFrame(targetFrame)
		elseif previousFrameSizes[curWin:id()] then
			curWin:setFrame(previousFrameSizes[curWin:id()])
			previousFrameSizes[curWin:id()] = nil
		else
			previousFrameSizes[curWin:id()] = curWinFrame
			curWin:setFrame(targetFrame)
		end
	end)
end

-- bindResizeAndRestoreToKeys("M", getMaxWinFrame)
-- bindResizeAndRestoreToKeys("H", getFillLeftWinFrame)
-- bindResizeAndRestoreToKeys("J", getFillBottomWinFrame)
-- bindResizeAndRestoreToKeys("K", getFillTopWinFrame)
-- bindResizeAndRestoreToKeys("L", getFillRightWinFrame)

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

hs.hotkey.bind(hyper, "H", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenWest(false, true, 0.5)
  frameCache[win:id()] = nil
end)

hs.hotkey.bind(hyper, "L", function()
  local win = hs.window.focusedWindow()
  win:moveOneScreenEast(false, true, 0.5)
  frameCache[win:id()] = nil
end)


hs.hotkey.bind(hyper, "J", function()
  zoomW(0.75);
end)

hs.hotkey.bind(hyper, "K", function()
  zoomW(1.25);
end)

hs.hotkey.bind(hyper, "U", function()
  zoomH(0.75);
end)

hs.hotkey.bind(hyper, "I", function()
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

