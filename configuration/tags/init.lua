local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')


local tags = {
  {
    icon = icons.brave,
    type = 'browser',
    defaultApp = 'brave-nightly',
    screen = 1
  },
  {
    icon = icons.terminal,
    type = 'terminal',
    defaultApp = 'alacritty',
    screen = 2
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = 'code',
    screen = 3
  },
  {
    icon = icons.book,
    type = 'book',
    defaultApp = 'foliate',
    screen = 4
  },
  {
    icon = icons.folder,
    type = 'files',
    defaultApp = "bash -c 'alacritty -e ranger'",
    screen = 5
  },
  {
    icon = icons.torrent,
    type = 'torrent',
    defaultApp = "bash -c 'alacritty -e rtorrent'",
    screen = 6
  },
  {
    icon = icons.lab,
    type = 'any',
    defaultApp = apps.default.rofi,
    screen = 7
  }
}

awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.max,
  awful.layout.suit.floating,
  awful.layout.suit.treetile,
}

awful.screen.connect_for_each_screen(
function(s)
	for i, tag in pairs(tags) do
		awful.tag.add(
		i,
		{
			icon = tag.icon,
			icon_only = true,
			layout = awful.layout.suit.tile,
			gap_single_client = false,
			gap = 4,
			screen = s,
			defaultApp = tag.defaultApp,
			selected = i == 1
		}
		)
	end
end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)
