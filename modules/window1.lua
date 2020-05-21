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
bindResizeAndRestoreToKeys("H", getFillLeftWinFrame)
bindResizeAndRestoreToKeys("J", getFillBottomWinFrame)
bindResizeAndRestoreToKeys("K", getFillTopWinFrame)
bindResizeAndRestoreToKeys("L", getFillRightWinFrame)

local frameCache = {}
function toggle_window(action)
    local win = hs.window.focusedWindow()
    if frameCache[win:id()] then
        win:setFrame(frameCache[win:id()])
        frameCache[win:id()] = nil
    else
        frameCache[win:id()] = win:frame()
        action()
    end
end

hs.hotkey.bind(hyper, 'F', function() 
  hs.window.focusedWindow():toggleFullScreen()
end)

hs.hotkey.bind(hyper, 'C', function() 
    toggle_window(function() hs.window.focusedWindow():centerOnScreen() end)
end)

hs.hotkey.bind(hyper, 'M', function() 
    toggle_window(function() hs.window.focusedWindow():maximize() end)
end)

hs.hotkey.bind(hyper, "U", function()
  hs.window.focusedWindow():moveOneScreenWest()
  -- hs.window.switcher.nextWindow()
end)
hs.hotkey.bind(hyper, "I", function()
  hs.window.focusedWindow():moveOneScreenEast()
  -- hs.window.switcher.previousWindow()
end)
