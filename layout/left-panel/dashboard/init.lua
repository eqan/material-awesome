local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local helpers = require("helpers")

local function format_progress_bar(bar, markup)
    local text = wibox.widget {
        markup = markup,
        align = 'center',
        valign = 'center',
        font = 'Roboto medium 12',
        widget = wibox.widget.textbox
    }
    text.forced_height = dpi(36)
    text.forced_width = dpi(36)
    text.resize = true

    local w = wibox.widget {text, bar, layout = wibox.layout.stack}
    return w
end

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(dpi(8))
    box_container.border_width = dpi(3)
    box_container.border_color = "#29343d"

    local boxed_widget = wibox.widget {
        {
            {
                nil,
                {
                    nil,
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal
            },
            widget = box_container
        },
        margins = dpi(8),
        color = "#FF000000",
        widget = wibox.container.margin
    }
    return boxed_widget
end


local ram_bar = require("widget.ram_squircle")
local ram = format_progress_bar(ram_bar, "<span foreground= #fbdf90'><b></b></span>")

local cpu_bar = require("widget.cpu_squircle")
local cpu = format_progress_bar(cpu_bar, "<span foreground= #a3b8ef'><b></b></span>")

local temp_bar = require("widget.temp_squircle")
local temp = format_progress_bar(temp_bar, "<span foreground= #f9929b'><b></b></span>")


return function(_, panel)
  local search_button =
    wibox.widget {
    wibox.widget {
      icon = icons.search,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'Search Applications',
      font = 'Roboto medium 13',
      widget = wibox.widget.textbox
    },
    clickable = true,
    widget = mat_list_item
  }

  search_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:run_rofi()
        end
      )
    )
  )

  local exit_button =
    wibox.widget {
    wibox.widget {
      icon = icons.logout,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'End work session',
      font = 'Roboto medium 13',
      widget = wibox.widget.textbox
    },
    clickable = true,
    divider = true,
    widget = mat_list_item
  }

  exit_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:toggle()
          _G.exit_screen_show()
        end
      )
    )
  )

  local sys = wibox.widget {
    {
        cpu,
        top = dpi(20),
        bottom = dpi(0),
        left = dpi(0),
        right = dpi(0),
        widget = wibox.container.margin
    },
    {
        {
            temp,
            top = dpi(0),
            bottom = dpi(20),
            left = dpi(10),
            right = dpi(0),
            widget = wibox.container.margin
        },
        {
            ram,
            top = dpi(0),
            bottom = dpi(20),
            left = dpi(0),
            right = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.flex.horizontal
    },
    spacing = dpi(0),
    layout = wibox.layout.flex.vertical
}

local sys_box = create_boxed_widget(sys, 400, 200,"#1a2026")

local panelWidget = wibox.widget {
    {sys_box, layout = wibox.layout.align.vertical},
    layout = wibox.layout.flex.horizontal
}


  return wibox.widget {
    layout = wibox.layout.align.vertical,
    {
      layout = wibox.layout.fixed.vertical,
      {
        search_button,
        bg = beautiful.background.hue_800,
        widget = wibox.container.background
      },
      wibox.widget {
        orientation = 'horizontal',
        forced_height = 1,
        opacity = 0.08,
        widget = wibox.widget.separator
      },
      --require('layout.left-panel.dashboard.quick-settings'),
      require('layout.left-panel.dashboard.hardware-monitor'),
    },
    nil,
    {
      layout = wibox.layout.fixed.vertical,
      {
        exit_button,
        bg = beautiful.background.hue_800,
        widget = wibox.container.background
      },
      -- Need help here
      --{nil, panelWidget, expand = "none", layout = wibox.layout.align.vertical},
    }
  }
end
