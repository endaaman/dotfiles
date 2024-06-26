local tym = require('tym')
local home = os.getenv('HOME')


function update_alpha(delta)
  r, g, b, old_alpha = tym.color_to_rgba(tym.get('color_background'))
  new_alpha = math.max(math.min(1.0, old_alpha + delta), 0.0)
  new_bg = tym.rgba_to_color(r, g, b, new_alpha)
  tym.set('color_background', new_bg)
  tym.notify(string.format('Alpha: %f → %f', old_alpha, new_alpha))
end

function update_scale(delta)
  old_value = tym.get('scale')
  new_value = math.max(math.min(1000, old_value + delta), 30)
  tym.set('scale', new_value)
  tym.notify(string.format('scale: %d → %d', old_value, new_value))
end

function safe_dofile(path)
  local f = io.open(path, 'r')
  if f ~= nil then
    io.close(f)
    dofile(path)
  end
end

tym.set_config({
  -- shell = home .. '/dotfiles/bin/tmux-attach-or-new',
  shell = 'tmux new -As0',
  cursor_blink_mode = 'off',
  autohide = true,
  silent = true,
  title = 'tym',
  cjk_width = 'narrow',
  font = 'Monospace 14',
  width = 140,
  height = 40,
})

function remap(b)
  return function()
    tym.send_key(b)
  end
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
    update_scale(10)
  end,
  ['<Ctrl><Shift>Down'] = function()
    update_scale(-10)
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
  ['<Ctrl>equal'] = function()
    tym.set('scale', 100)
    r, g, b, old_alpha = tym.color_to_rgba(tym.get('color_background'))
    tym.set('color_background', tym.rgba_to_color(r, g, b, 1))
    tym.notify('Reset alpha and scale')
  end,
  ['<Ctrl><Shift>plus'] = function()
    local s = tym.get('scale') + 10
    tym.set('scale', s)
    tym.notify('Scale:'..s)
  end,
  ['<Ctrl>minus'] = function()
    local s = tym.get('scale') - 10
    tym.set('scale', s)
    tym.notify('Scale:'..s)
  end,
  ['<Alt>h'] = remap('<Alt>Left'),
  ['<Alt>l'] = remap('<Alt>Right'),
  ['<Alt><Shift>h'] = remap('<Alt><Shift>Left'),
  ['<Alt><Shift>l'] = remap('<Alt><Shift>Right'),
  ['<Ctrl>Tab'] = remap('<Ctrl>n'),
  ['<Ctrl><Shift>Tab'] = remap('<Ctrl>p'),
})

tym.set_hooks({
  scroll = function(dx, dy, x, y)
    if tym.check_mod_state('<Ctrl>') then
      update_scale(dy < 0 and 10 or -10)
      return true
    end
    if tym.check_mod_state('<Shift>') then
      update_alpha(dy < 0 and 0.05 or -0.05)
      return true
    end
  end
})

safe_dofile(home .. '/.config/tym/local.lua')
