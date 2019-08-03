local tym = require('tym')
local home = os.getenv('HOME')

tym.set_config({
  width = 120,
  height = 32,
  shell = home .. '/dotfiles/bin/tmux-attach-or-new',
  cursor_blink_mode = 'off',
  autohide = true,
})


function update_alpha(delta)
  r, g, b, a = tym.color_to_rgba(tym.get('color_background'))
  a = math.max(math.min(1.0, a + delta), 0.0)
  bg = tym.rgba_to_color(r, g, b, a)
  tym.set('color_background', bg)
  tym.notify(string.format('%s alpha to %f', (delta > 0 and 'Inc' or 'Dec'), a))
  tym.apply()
end

tym.set_keymaps({
  ['<Ctrl><Shift>r'] = function()
    tym.reload()
    tym.notify('Reloaded')
  end,
  ['<Ctrl><Shift>u'] = function()
    tym.reset_config()
    tym.reload()
    tym.notify('Reset and Reloaded')
  end,
  ['<Ctrl><Shift>Up'] = function()
    update_alpha(0.05)
  end,
  ['<Ctrl><Shift>Down'] = function()
    update_alpha(-0.05)
  end,
  ['<Ctrl><Shift>g'] = function()
    tym.set_timeout(coroutine.wrap(function()
      tym.send_key('<Alt>t')
      coroutine.yield(true)
      tym.send_key('<Ctrl>g')
      coroutine.yield(true)
      tym.send_key('<Ctrl>m')
      coroutine.yield(false)
    end), 100)
  end,
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
