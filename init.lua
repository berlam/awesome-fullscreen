local os = os
local client = client
local pairs = pairs

module("awesome-fullscreen")

local settings = {
	callback = function(screen, ontop) end
}

-- {{{ Make fullscreen clients ontop
local fullscreenwindows = {}

client.connect_signal("unmanage", function(c) 
	fullscreenwindows[c.window] = nil
end)

client.connect_signal("property::fullscreen", function(c)
settings.callback(c.screen, not c.fullscreen)
if c.fullscreen == true then 
	fullscreenwindows[c.window] = true
else
	fullscreenwindows[c.window] = nil
end
local somewindowinfullscreen = false 
-- Toggle power save functionality and blanking
for _, w in pairs(fullscreenwindows) do 
	if w == true then
		somewindowinfullscreen = true	
		break	
	end
end
if (somewindowinfullscreen) then
	os.execute("xset s off && xset -dpms && xset s noblank")
else
	os.execute("xset s on && xset +dpms && xset s blank")
end
end)
-- }}}
return settings
