local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local gears = require('gears')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local TagList = require('widget.tag-list')
local clickable_container = require('widget.material.clickable-container')
local weather_widget = require("widget.weather.weather")
local volume_widget = require('widget.volume.volume')
local brightness_widget = require("widget.brightness.brightness")

return function(screen, panel, action_bar_width)
  -- Clock / Calendar 24h format
  --local textclock = wibox.widget.textclock('<span font="Roboto Mono 8">%H\n%M</span>')

-- Clock / Calendar 12AM/PM fornat
-- local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 8"> %d\n %m\n ----\n</span><span font="Roboto Mono bold 8"> %I\n %M\n</span><span font="Roboto Mono bold 7"> %p</span>')
 local textclock = wibox.widget.textclock('<span font="Roboto Mono bold 8">%I:%M</span><span font="Roboto Mono bold 7">%p</span>')
 local date = wibox.widget.textclock('<span font="Roboto Mono bold 8">%d.%m.%y</span>')
 date.align = 'center'
 textclock.align = 'center'

-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month({
  screen = s,
  start_sunday = false,
  week_numbers = true,
})

month_calendar:attach(date)

local date_widget = wibox.container.margin(date, dpi(0), dpi(0), dpi(5), dpi(5))
local clock_widget = wibox.container.margin(textclock, dpi(0), dpi(0), dpi(5), dpi(5))

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  return layoutBox
end

  local systray = wibox.widget.systray()
  systray:set_horizontal(false)
  systray:set_base_size(24)

  local menu_icon =
    wibox.widget {
    icon = icons.menu,
    size = dpi(24),
    widget = mat_icon
  }

  local home_button =
    wibox.widget {
    wibox.widget {
      menu_icon,
      widget = clickable_container
    },
    bg = beautiful.primary.hue_500,
    widget = wibox.container.background
  }

  home_button:buttons(
    gears.table.join(
      awful.button(
        {},
        1,
        nil,
        function()
          panel:toggle()
        end
      )
    )
  )

  panel:connect_signal(
    'opened',
    function()
      menu_icon.icon = icons.close
    end
  )

  panel:connect_signal(
    'closed',
    function()
      menu_icon.icon = icons.menu
    end
  )

  return wibox.widget {
    id = 'action_bar',
    layout = wibox.layout.align.vertical,
    forced_width = action_bar_width,
    {
      -- Left widgets
      layout = wibox.layout.fixed.vertical,
      home_button,
      -- Create a taglist widget
      TagList(screen),
    },
    --s.mytasklist, -- Middle widget
    nil,
    {
      -- Right widgets
      layout = wibox.layout.fixed.vertical,
      wibox.container.margin(systray, dpi(10), dpi(10)),
      --require('widget.package-updater'),
      weather_widget({
        api_key='ecad7a8a23193461bdfe1ea598ad3b5e',
        coordinates = {31.7584, 72.9165},
        time_format_12h = true,
        units = 'metric',
        both_units_widget = false,
        font_name = 'Roboto Mono Regular',
        icons = 'material-icons',
        icons_extension = '.svg',
        show_hourly_forecast = true,
        show_daily_forecast = true,
        }),
      --require('widget.screen-recorder'),
      brightness_widget{
            type = 'icon_and_text',
            program = 'xbacklight',
            step = 2,
          },
        volume_widget{
            type = 'icon_and_text'
        },
      require('widget.wifi'),
      require('widget.battery'),
      --require('volume'),
      -- Clock
      clock_widget,
      date_widget,
      -- LayoutBox
      LayoutBox(screen)
    }
  }
end
