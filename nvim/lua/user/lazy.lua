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

require('lazy').setup({
  'editorconfig/editorconfig-vim',
  'jiangmiao/auto-pairs',
  'gregsexton/MatchTag',
  'tpope/vim-surround',
  -- 'tpope/vim-commentary',
  'numToStr/Comment.nvim',
  'Yggdroot/indentLine',
  'airblade/vim-gitgutter',
  'itchyny/vim-cursorword',
  'simeji/winresizer',
  'kana/vim-textobj-user',

  { 'sgur/vim-textobj-parameter', dependencies = { 'kana/vim-textobj-user' } },
  require('plugins.telescope'),
  require('plugins.fern'),
  require('plugins.appearance'),
  require('plugins.treesitter'),
  require('plugins.completion'),
})
