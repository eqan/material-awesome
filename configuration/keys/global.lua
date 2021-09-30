local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget
local brightness_widget = require("widget.brightness.brightness")
local volume_widget = require('widget.volume.volume')
local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')
-- Key bindings

local globalKeys =
  awful.util.table.join(
  -- Hotkeys

  awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'show help', group = 'awesome'}),

  -- Custom Hot keys
  awful.key({modkey}, "b", function () awful.util.spawn_with_shell("brave-nightly") end),
  awful.key({modkey}, "v", function () awful.util.spawn_with_shell("vscodium") end),
  awful.key({modkey}, "d", function () awful.util.spawn_with_shell("nautilus") end),
  awful.key({modkey}, "s", function() awful.util.spawn_with_shell("bash -c 'alacritty -e ranger'") end),
  awful.key({modkey}, "o", function() awful.util.spawn_with_shell("bash -c 'rofimoji'") end),
  awful.key({modkey}, "n", function() awful.util.spawn_with_shell("bash -c 'rofi-wifi-menu'") end),
  awful.key({modkey}, "p", function() awful.util.spawn_with_shell("bash -c 'rofi -show power-menu -modi power-menu:rofi-power-menu'") end),
  awful.key({modkey}, "a", function() awful.util.spawn_with_shell("bash -c '~/.config/rofi/scripts/battery.sh'") end),
  awful.key({modkey}, "c", function() awful.util.spawn_with_shell("bash -c 'rofi -show calc -modi calc -no-show-match -no-sort'") end),
  awful.key({modkey, "Shift"}, "r", function() awful.util.spawn_with_shell("bash -c 'alacritty -e rtorrent'") end),
  awful.key({modkey, 'Shift'}, "s", function() awful.util.spawn_with_shell("scrot -s '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/shots/'") end),
  awful.key({modkey, 'Shift'}, "f", function() awful.util.spawn_with_shell("scrot '%Y-%m-%d_$wx$h.png' -e 'mv $f ~/shots/'") end),
 -- awful.key({modkey, "Shift"}, "l", function() awful.util.spawn_with_shell('dm-tool lock') end),
  awful.key({altkey, "shift"}, "l", function() awful.util.spawn_with_shell("betterlockscreen -l") end),
  awful.key({altkey, "Shift"}, "v", function() awful.util.spawn_with_shell("bash -c 'screenkey'") end),
  awful.key({modkey, "Shift"}, "x", function() awful.util.spawn_with_shell("bash -c 'mw -Y'") end),
  awful.key({modkey, "Shift"}, "b", function() awful.util.spawn_with_shell("bash -c 'alacritty -e neomutt'") end),
  awful.key({modkey, "Shift"}, "p", function() awful.util.spawn_with_shell("bash -c 'grabc | parcellite -c'") end),
  awful.key({modkey, "Shift"}, "d", function() awful.util.spawn_with_shell("bash -c 'onboard'") end),
  awful.key({modkey}, "g", function() awful.util.spawn_with_shell("surf https://google.com") end),

  -- Default client focus
  awful.key({modkey}, 'k', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
  awful.key({modkey}, 'j', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
  awful.key({modkey}, 'Up', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
  awful.key({modkey}, 'Down', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
  awful.key({modkey}, 'e', function() _G.screen.primary.left_panel:toggle(true) end, {description = 'Rofi Search', group = 'awesome'}),
  awful.key({modkey}, 'm', function() _G.screen.primary.left_panel:toggle(false) end, {description = 'Show DashBoard', group = 'awesome'}),
  awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'client'}),
  awful.key({altkey}, 'Tab',    function()      awful.client.focus.history.previous()      awful.client.focus.byidx(1)      if _G.client.focus then        _G.client.focus:raise()      end    end,    {description = 'Switch to next window', group = 'client'}  ),
  awful.key({altkey, 'Shift'},    'Tab',    function()      awful.client.focus.history.previous()      awful.client.focus.byidx(-1)      if _G.client.focus then        _G.client.focus:raise()      end    end,    {description = 'Switch to previous window', group = 'client'}  ),

  -- Standard program
  awful.key({modkey},'x',    function()      awful.spawn(apps.default.terminal)    end,    {description = 'open a terminal', group = 'launcher'}  ),
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),

  -- Normal Key Bindings | Arrow keys
  awful.key({modkey}, 'Left',  function()  awful.client.focus.byidx(1)   end,  {description = 'focus next by index', group = 'client'}  ), 
  awful.key({modkey}, 'Right', function()      awful.client.focus.byidx(-1)    end,    {description = 'focus previous by index', group = 'client'}  ),
  awful.key({modkey, 'Shift'},    'Right',   function()      awful.tag.incmwfact(0.05)    end,    {description = 'increase master width factor', group = 'layout'}  ),
  awful.key({modkey, 'Shift'},    'Left',    function()      awful.tag.incmwfact(-0.05)    end,    {description = 'decrease master width factor', group = 'layout'}  ),
  awful.key({modkey, 'Shift'},    'Right',   function()      awful.tag.incmwfact(0.05)    end,    {description = 'increase master width factor', group = 'layout'}  ),
  awful.key({modkey, 'Shift'},    'Left',    function()      awful.tag.incmwfact(-0.05)    end,    {description = 'decrease master width factor', group = 'layout'}  ),
  awful.key({modkey, 'Shift'},    'Up',      function()      awful.tag.incnmaster(1, nil, true)    end,    {description = 'increase the number of master clients', group = 'layout'}  ),
  awful.key({modkey, 'Shift'},    'Down',    function()      awful.tag.incnmaster(-1, nil, true)    end,    {description = 'decrease the number of master clients', group = 'layout'}  ),

  -- Vim Key Bindings | For regular usage
  awful.key({modkey}, 'h',  function()  awful.client.focus.byidx(1) end,  {description = 'focus next by index', group = 'client'}), 
  awful.key({modkey},  'l',  function()    awful.client.focus.byidx(-1)  end,  {description = 'focus previous by index', group = 'client'}),
  awful.key({modkey, 'Shift'},  'l',  function()    awful.tag.incmwfact(0.05)  end,  {description = 'increase master width factor', group = 'layout'}),
  awful.key({modkey, 'Shift'},  'h',  function()    awful.tag.incmwfact(-0.05)  end,  {description = 'decrease master width factor', group = 'layout'}),
  awful.key({modkey, 'Shift'},  'k',  function()    awful.client.incwfact(0.05)  end,  {description = 'decrease master height factor', group = 'layout'}),
  awful.key({modkey, 'Shift'},  'j',  function()    awful.client.incwfact(-0.05)  end,  {description = 'increase master height factor', group = 'layout'}),
  awful.key({modkey, 'Control'},  'k',  function()    awful.tag.incnmaster(1, nil, true)  end,  {description = 'increase the number of master clients', group = 'layout'}),
  awful.key({modkey, 'Control'},  'j',  function()    awful.tag.incnmaster(-1, nil, true)  end,  {description = 'decrease the number of master clients', group = 'layout'}),
  awful.key({modkey, 'Control'},  'Right',  function()    awful.tag.incncol(1, nil, true)  end,  {description = 'increase the number of columns', group = 'layout'}),
  awful.key({modkey, 'Control'},  'Left',  function()    awful.tag.incncol(-1, nil, true)  end,  {description = 'decrease the number of columns', group = 'layout'}),
  awful.key({modkey}, 'space',  function()    awful.layout.inc(1)  end,  {description = 'select next', group = 'layout'}),
  awful.key({modkey, 'Shift'},  'space',  function()    awful.layout.inc(-1)  end,  {description = 'select previous', group = 'layout'}),
  awful.key({modkey, 'Control'},  'n',  function()    local c = awful.client.restore()  --   Focus restored client
    if c then      _G.client.focus = c      c:raise()    end  end,  {description = 'restore minimized', group = 'client'}),

-- Dropdown application
  awful.key({modkey},  'z',  function()    _G.toggle_quake()  end,  {description = 'dropdown application', group = 'launcher'}),

-- Widgets popups

-- Brightness
  awful.key({altkey}, "0", function () brightness_widget:inc() end, {description = "increase brightness", group = "custom"}),
  awful.key({altkey}, "9", function () brightness_widget:dec() end, {description = "decrease brightness", group = "custom"}),
  awful.key({altkey}, '0', function() awful.spawn('xbacklight -inc 10')end, {description = '+10%', group = 'hotkeys'}),
  awful.key({altkey}, '9', function()  awful.spawn('xbacklight -dec 10') end,{description = '-10%', group = 'hotkeys'}),
  awful.key({}, 'XF86MonBrightnessUp', function()  awful.spawn('xbacklight -inc 10') end,{description = '+10%', group = 'hotkeys'}),
  awful.key({}, 'XF86MonBrightnessDown', function()  awful.spawn('xbacklight -dec 10') end,{description = '-10%', group = 'hotkeys'}),

  -- Amixer volume control
  awful.key({altkey}, "p", function() volume_widget:inc() end),
  awful.key({altkey}, "o", function() volume_widget:dec() end),
  awful.key({altkey}, "i", function() volume_widget:toggle() end),
  --awful.key({modkey},  ']',  function()    awful.spawn('amixer -D pulse set Master 5%+')  end,  {description = 'volume up', group = 'hotkeys'}),
  --awful.key( {modkey}, '[',  function()--  awful.spawn('amixer -D pulse set Master 5%-')  end,  {description = 'volume down', group = 'hotkeys'}),
  --awful.key({modkey},'/',function()  awful.spawn('amixer -D pulse set Master 1+ toggle')end,{description = 'toggle mute', group = 'hotkeys'}
  awful.key({},  'XF86AudioRaiseVolume',  function()    awful.spawn('amixer -D pulse sset Master 5%+')  end,  {description = 'volume up', group = 'hotkeys'}),
  awful.key({},  'XF86AudioLowerVolume',  function()    awful.spawn('amixer -D pulse sset Master 5%-')  end,  {description = 'volume down', group = 'hotkeys'}),
  awful.key({},  'XF86AudioMute',  function()    awful.spawn('amixer -D pulse set Master 1+ toggle')  end,  {description = 'toggle mute', group = 'hotkeys'}),
  awful.key({},  'XF86AudioNext',  function()      end,  {description = 'toggle mute', group = 'hotkeys'}),
  awful.key({},  'XF86PowerDown',  function()      end,  {description = 'toggle mute', group = 'hotkeys'}),
  awful.key({},  'XF86PowerOff',  function()    _G.exit_screen_show()  end,  {description = 'toggle mute', group = 'hotkeys'}),

  -- Screen management
  awful.key({modkey},    'o',    awful.client.movetoscreen,    {description = 'move window to next screen', group = 'client'}  ),

  -- Open default program for tag
  awful.key({modkey},    't',    function()      awful.spawn(          awful.screen.focused().selected_tag.defaultApp,          {            tag = _G.mouse.screen.selected_tag,            placement = awful.placement.bottom_right          }        )    end,    {description = 'open default program for tag/workspace', group = 'tag'}  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = {description = 'view tag #', group = 'tag'}
    descr_toggle = {description = 'toggle tag #', group = 'tag'}
    descr_move = {description = 'move focused client to tag #', group = 'tag'}
    descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
  end
  globalKeys =
    awful.util.table.join(
    globalKeys,
    -- View tag only.
    awful.key({modkey},  '#' .. i + 9,  function()    local screen = awful.screen.focused()    local tag = screen.tags[i]    if tag then      tag:view_only()    end  end,  descr_view),
    -- Toggle tag display.
    awful.key({modkey, 'Control'},  '#' .. i + 9,  function()    local screen = awful.screen.focused()    local tag = screen.tags[i]    if tag then      awful.tag.viewtoggle(tag)    end  end,  descr_toggle),
    -- Move client to tag.
    awful.key({modkey, 'Shift'},  '#' .. i + 9,  function()    if _G.client.focus then      local tag = _G.client.focus.screen.tags[i]      if tag then        _G.client.focus:move_to_tag(tag)      end    end  end,  descr_move),
    -- Toggle tag on focused client.
    awful.key({modkey, 'Control', 'Shift'},  '#' .. i + 9,  function()    if _G.client.focus then      local tag = _G.client.focus.screen.tags[i]      if tag then        _G.client.focus:toggle_tag(tag)      end    end  end,  descr_toggle_focus)
  )
end

return globalKeys

