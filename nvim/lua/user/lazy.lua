local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.indentLine_char = ''
-- vim.g.indentLine_char = '¦'
vim.g.indentLine_setConceal = 1
vim.g.indentLine_fileTypeExclude = {'nerdtree', 'markdown', 'fern'}

vim.g.vim_textobj_parameter_mapping = 'a'
vim.g.winresizer_start_key = '<Space>R'
-- autocmd EN BufWritePost * :GitGutter

require('lazy').setup({
  { 'editorconfig/editorconfig-vim' },
  { 'jiangmiao/auto-pairs' },
  { 'gregsexton/MatchTag' },
  { 'tpope/vim-surround' },
  { 'numToStr/Comment.nvim' },
  { 'Yggdroot/indentLine' },
  { 'simeji/winresizer' },
  { 'kana/vim-textobj-user' },
  { 'sgur/vim-textobj-parameter', dependencies = { 'kana/vim-textobj-user' } },
  -- 'itchyny/vim-cursorword',
  -- 'tpope/vim-commentary',

  {
    'airblade/vim-gitgutter',
    config=function()
      vim.keymap.set('n', '<C-k>', ':<C-u>GitGutterPrevHunk<CR>')
      vim.keymap.set('n', '<C-j>', ':<C-u>GitGutterNextHunk<CR>')
    end
  },

  require('plugins.telescope'),
  require('plugins.fern'),
  require('plugins.appearance'),
  require('plugins.treesitter'),
  require('plugins.completion'),
})
