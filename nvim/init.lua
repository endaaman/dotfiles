local function reset_config()
  -- モジュールをアンロード
  for name, _ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end

  -- キーマッピングをクリア
  -- ノーマルモード
  for _, key in ipairs(vim.api.nvim_get_keymap('n')) do
    if key.buffer == 0 then
      pcall(vim.keymap.del, 'n', key.lhs)
   end
  end

  for _, mode in ipairs({'i', 'v', 'x', 'c', 't'}) do
    for _, key in ipairs(vim.api.nvim_get_keymap(mode)) do
      if key.buffer == 0 then
        pcall(vim.keymap.del, mode, key.lhs)
      end
    end
  end

  -- オートコマンドをクリア
  vim.api.nvim_clear_autocmds({})

  vim.notify('Reset all config', vim.log.levels.INFO)
end

local function load_config()
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
  vim.keymap.set('n', '<Leader>r', reload_config, { desc = 'Reload configuration' })

  dofile(vim.fn.stdpath('config') .. '/lua/init.lua')
end

local function reload_config()
  reset_config()
  load_config()
  vim.notify('Reloaded custom config.', vim.log.levels.INFO)
end


vim.api.nvim_create_user_command('Reload', function()
  reload_config()
end, {})

load_config()
