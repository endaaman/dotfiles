local tym = require('tym')
local home = os.getenv('HOME')


function update_alpha(delta)
  r, g, b, a = tym.color_to_rgba(tym.get('color_background'))
  a = math.max(math.min(1.0, a + delta), 0.0)
  bg = tym.rgba_to_color(r, g, b, a)
  tym.set('color_background', bg)
  tym.notify(string.format('%s alpha to %f', (delta > 0 and 'Inc' or 'Dec'), a))
end

function remap(a, b)
  tym.set_keymap(a, function()
    tym.send_key(b)
  end)
end

function safe_dofile(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    dofile(path)
  end
end

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

tym.set_hooks({
  scroll = function(dx, dy, x, y)
    if tym.check_mod_state('<Ctrl>') then
      if dy > 0 then
        s = tym.get('scale') - 10
      else
        s = tym.get('scale') + 10
      end
      tym.set('scale', s)
      tym.notify('Scale: ' .. s .. '%')
      return true
    end
    if tym.check_mod_state('<Shift>') then
      update_alpha(dy < 0 and 0.05 or -0.05)
      return true
    end
  end
})

remap('<Alt>h', '<Alt>Left')
remap('<Alt>l', '<Alt>Right')
remap('<Alt><Shift>h', '<Alt><Shift>Left')
remap('<Alt><Shift>l', '<Alt><Shift>Right')

safe_dofile(home .. '/.config/tym/local.lua')
