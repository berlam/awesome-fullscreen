local os = os
local client = client
local pairs = pairs

local _M = {}

_M.settings = {
	callback = function(screen, ontop) end
}

-- {{{ Make fullscreen clients ontop
_M.fullscreenwindows = {}

client.connect_signal("unmanage", function(c) 
	_M.fullscreenwindows[c.window] = nil
end)

client.connect_signal("property::fullscreen", function(c)
_M.settings.callback(c.screen, not c.fullscreen)
if c.fullscreen == true then 
	_M.fullscreenwindows[c.window] = true
else
	_M.fullscreenwindows[c.window] = nil
end
local somewindowinfullscreen = false 
-- Toggle power save functionality and blanking
for _, w in pairs(_M.fullscreenwindows) do 
	if w == true then
		somewindowinfullscreen = true	
		break	
	end
end
if (somewindowinfullscreen) then
	os.execute("test -x /usr/bin/xfconf-query && xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true --create -t bool")
	os.execute("test -x /usr/bin/xautolock && xautolock -disable")
	--os.execute("xset -dpms && xset s off")
else
	os.execute("test -x /usr/bin/xfconf-query && xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false --create -t bool")
	os.execute("test -x /usr/bin/xautolock && xautolock -enable")
	--os.execute("xset +dpms && xset s on")
end
end)
-- }}}
return _M.settings
