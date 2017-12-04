config.width = 120
config.height = 32
config.shell = os.getenv('HOME') .. '/dotfiles/bin/tmux-attach-or-new'
config.title = 'tym'
config.cursor_blink_mode = 'off'
config.cjk_width = 'narrow'
config.use_default_keymap = true

keymap = {}
keymap['<Ctrl><Shift>r'] = function()
  tym.reload()
  tym.notify('reloaded')
end

dofile(os.getenv('HOME') .. '/.config/tym/colors/hybrid.lua')

function safe_dofile(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    dofile(path)
  end
end
safe_dofile(os.getenv('HOME') .. '/.config/tym/local.lua')

-- color_0  : black (background)
-- color_1  : red
-- color_2  : green
-- color_3  : brown
-- color_4  : blue
-- color_5  : purple
-- color_6  : cyan
-- color_7  : light gray (foreground)
-- color_8  : gray
-- color_9  : light red
-- color_10 : light green
-- color_11 : yellow
-- color_12 : light blue
-- color_13 : pink
-- color_14 : light cyan
-- color_15 : white
