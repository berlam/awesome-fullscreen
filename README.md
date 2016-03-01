awesome-fullscreen
==================

A [awesome wm](https://github.com/awesomeWM/awesome) plugin that toggles ontop elements when another component goes fullscreen.
While a component is in fullscreen the energy savers are turned off (e.g. disabled blank screen).

## Installation ##

Clone the repo into your `$XDG_CONFIG_HOME/awesome` directory and add the dependency to your `rc.lua`.

```Lua
awfs = require("awesome-fullscreen")
```

## Configuration ##

You can configure the callback function by passing a function to the settings object.
The function is called with the screen number of the fullscreen client and a boolean which is true, when other element can be ontop again.

```Lua
awfs.callback = function(screen, ontop)
	client[screen].ontop = ontop
end
```

## License ##

See [LICENSE](LICENSE).
