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
overwrite('<Alt>t', '<Ctrl><Alt>t')

function safe_dofile(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    dofile(path)
  end
end
safe_dofile(home .. '/.config/tym/local.lua')
