vim.g['fern#default_hidden'] = 1
vim.g['fern#hide_cursor'] = 1
local hide_dirs = '^\\%(\\.git\\|node_modules\\|__pycache__\\)$'
local hide_files = '\\%(\\.byebug\\|\\.ruby-\\)\\+'
vim.g['fern#default_exclude'] = hide_dirs .. '\\|' .. hide_files
vim.g['fern#disable_default_mappings'] = 1
vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern_git_status#disable_submodules'] = 1

function config()
  vim.api.nvim_set_keymap('n', '<C-g>', ':<C-u>Fern . -drawer -width=40 -toggle -reveal=%<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<Space><C-g>', ':<C-u>Fern %:h -drawer -width=40 -toggle -reveal=%<CR>', { noremap = true, silent = true })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "fern",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.cursorcolumn = false

      vim.cmd([[
        nnoremap <buffer> <Plug>(fern-close-drawer) :<C-u>FernDo close -drawer -stay<CR>
        nmap <buffer><silent><expr>
          \ <Plug>(fern-my-open-close-expand-collapse)
          \ fern#smart#leaf(
          \   "\<Plug>(fern-action-open)\<Bar>:<C-u>FernDo close -drawer -stay<CR>",
          \   "\<Plug>(fern-action-expand)",
          \   "\<Plug>(fern-action-collapse)",
          \ )
      ]])

      vim.api.nvim_buf_set_keymap(0, 'n', 'o', '<Plug>(fern-my-open-close-expand-collapse)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', '<C-m>', '<Plug>(fern-my-open-close-expand-collapse)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'O', '<Plug>(fern-action-open)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'x', '<Plug>(fern-action-collapse)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 't', '<Plug>(fern-action-open:tabedit)gT:<C-u>FernDo close -drawer -stay<CR>gt', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'T', '<Plug>(fern-action-open:tabedit)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'i', '<Plug>(fern-action-open:split)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 's', '<Plug>(fern-action-open:vsplit)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'X', '<Plug>(fern-action-open:system)', {})

      vim.api.nvim_buf_set_keymap(0, 'n', 'M', '<Plug>(fern-action-rename:bottom)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'D', '<Plug>(fern-action-trash=)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'C', '<Plug>(fern-action-enter)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'R', '<Plug>(fern-action-reload)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'A', '<Plug>(fern-action-new-path=)', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'm', '<Plug>(fern-action-mark)j', {})
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Plug>(fern-close-drawer)', {})
    end,
  })
end

return {
  {
    'lambdalisue/fern.vim',
    dependencies = {
      { 'lambdalisue/nerdfont.vim' },
      { 'lambdalisue/fern-renderer-nerdfont.vim' },
      { 'lambdalisue/glyph-palette.vim' },
    },
    config = config,
  },
  { 'lambdalisue/fern-git-status.vim', dependencies = { 'lambdalisue/fern.vim' } },
}
