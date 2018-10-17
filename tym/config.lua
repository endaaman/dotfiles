local tym = require('tym')
local home = os.getenv('HOME')

tym.set_config({
  width = 120,
  height = 32,
  shell = home .. '/dotfiles/bin/tmux-attach-or-new',
  cursor_blink_mode = 'off',
  autohide = true,
})

tym.set_keymaps({
  ['<Ctrl><Shift>r'] = function()
    tym.reload()
    tym.notify('reloaded')
  end
})
local overwrite = function (a, b)
  tym.set_keymap(a, function()
    tym.send_key(b)
  end)
end
overwrite('<Alt>h', '<Alt>Left')
overwrite('<Alt>l', '<Alt>Right')
overwrite('<Alt><Shift>h', '<Alt><Shift>Left')
overwrite('<Alt><Shift>l', '<Alt><Shift>Right')

function safe_dofile(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    dofile(path)
  end
end
safe_dofile(home .. '/.config/tym/local.lua')

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
