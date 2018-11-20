local tym = require('tym')
local home = os.getenv('HOME')

tym.set_config({
  width = 120,
  height = 32,
  shell = 'tmux-attach-or-new',
  cursor_blink_mode = 'off',
  autohide = true,
})

tym.set_keymaps({
  ['<Ctrl><Shift>r'] = function()
    tym.reload()
    tym.notify('Reloaded')
  end,
  ['<Ctrl><Shift>u'] = function()
    tym.reset_config()
    tym.reload()
    tym.notify('Reset and Reloaded')
  end
})
local remap = function (a, b)
  tym.set_keymap(a, function()
    tym.send_key(b)
  end)
end
remap('<Alt>h', '<Alt>Left')
remap('<Alt>l', '<Alt>Right')
remap('<Alt><Shift>h', '<Alt><Shift>Left')
remap('<Alt><Shift>l', '<Alt><Shift>Right')

function safe_dofile(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    dofile(path)
  end
end
safe_dofile(home .. '/.config/tym/local.lua')
