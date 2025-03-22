-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

local act = wezterm.action

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'AdventureTime'

config.enable_scroll_bar=true

config.font = wezterm.font_with_fallback {
  'MyricaM M',
  'Myrica M',
}

if wezterm.target_triple == 'x86_64-apple-darwin' then
  config.font_size = 18.0

  config.initial_cols = 100
  config.initial_rows = 40
end

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.font_size = 10.0

  config.initial_cols = 180
  config.initial_rows = 80

   config.default_prog = { 'c:/cygwin64/bin/fish', '-l'}
end

config.window_background_opacity = 0.70

config.keys = {
  { key = 'l', mods = 'ALT|CMD', action = wezterm.action.ShowLauncher },
  {
    key = 't',
    mods = 'ALT',
    -- action = act.SpawnTab 'CurrentPaneDomain',
    action = act.SpawnCommandInNewTab {
       args = { 'cmd.exe' }
    },
  },
}

config.launch_menu = {
  {
    args = { 'top' },
  },
  {
    -- Optional label to show in the launcher. If omitted, a label
    -- is derived from the `args`
    label = 'Bash',
    -- The argument array to spawn.  If omitted the default program
    -- will be used as described in the documentation above
    args = { 'bash', '-l' },

    -- You can specify an alternative current working directory;
    -- if you don't specify one then a default based on the OSC 7
    -- escape sequence will be used (see the Shell Integration
    -- docs), falling back to the home directory.
    -- cwd = "/some/path"

    -- You can override environment variables just for this command
    -- by setting this here.  It has the same semantics as the main
    -- set_environment_variables configuration option described above
    -- set_environment_variables = { FOO = "bar" },
  },
}

-- https://wezterm.org/config/mouse.html#configuring-mouse-assignments#:~:text=delta
config.mouse_bindings = {
  -- Scrolling up while holding CTRL increases the font size
  {
    event = { Down = { streak = 1, button = { WheelUp = 1 } } },
    mods = 'CTRL',
    action = act.IncreaseFontSize,
  },

  -- Scrolling down while holding CTRL decreases the font size
  {
    event = { Down = { streak = 1, button = { WheelDown = 1 } } },
    mods = 'CTRL',
    action = act.DecreaseFontSize,
  },
}

-- and finally, return the configuration to wezterm
return config
