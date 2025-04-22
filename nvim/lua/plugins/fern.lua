-- Fern設定ファイル

-- キーマッピング
vim.api.nvim_set_keymap('n', '<C-g>', ':<C-u>Fern . -drawer -width=40 -toggle -reveal=%<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><C-g>', ':<C-u>Fern %:h -drawer -width=40 -toggle -reveal=%<CR>', { noremap = true, silent = true })

-- グローバル設定
vim.g['fern#default_hidden'] = 1
vim.g['fern#hide_cursor'] = 1
local hide_dirs = '^\\%(\\.git\\|node_modules\\|__pycache__\\)$'
local hide_files = '\\%(\\.byebug\\|\\.ruby-\\)\\+'
vim.g['fern#default_exclude'] = hide_dirs .. '\\|' .. hide_files
vim.g['fern#disable_default_mappings'] = 1

-- リッチレンダラー設定
if vim.g.rich then
  vim.g['fern#renderer'] = 'nerdfont'
  -- vim.g['fern#renderer'] = 'devicons'
end

-- Git status設定
vim.g['fern_git_status#disable_submodules'] = 1

-- Fernバッファの初期化関数
local function init_fern()
  vim.opt_local.number = false
  vim.opt_local.cursorcolumn = false

  -- プラグマッピングの定義
  vim.cmd([[
    nnoremap <buffer> <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
    nmap <buffer><silent> <Plug>(fern-my-open-and-close)
        \ <Plug>(fern-action-open)
        \ <Plug>(fern-close-drawer)
    nmap <buffer><silent><expr>
      \ <Plug>(fern-my-open-close-expand-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-my-open-and-close)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
    nmap <buffer><silent><expr>
      \ <Plug>(fern-my-open-expand-collapse)
      \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
  ]])

  -- バッファローカルのキーマッピング
  local map_opts = { noremap = true, silent = true, buffer = true }
  vim.api.nvim_buf_set_keymap(0, 'n', 'o', '<Plug>(fern-my-open-close-expand-collapse)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'O', '<Plug>(fern-my-open-expand-collapse)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', '<C-m>', '<Plug>(fern-action-open)<Plug>(fern-close-drawer)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'x', '<Plug>(fern-action-collapse)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'C', '<Plug>(fern-action-enter)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 't', '<Plug>(fern-action-open:tabedit)gT:<C-u>FernDo close -drawer -stay<CR>gt', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'T', '<Plug>(fern-action-open:tabedit)gT', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'i', '<Plug>(fern-action-open:split)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 's', '<Plug>(fern-action-open:vsplit)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'X', '<Plug>(fern-action-open:system)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'R', '<Plug>(fern-action-reload)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'A', '<Plug>(fern-action-new-path=)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'm', '<Plug>(fern-action-mark)j', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'M', '<Plug>(fern-action-rename:bottom)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'D', '<Plug>(fern-action-trash=)', {})
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':<C-u>quit<CR>', map_opts)
end


return {
  init_fern = init_fern,
  on_highlight = on_highlight
}
