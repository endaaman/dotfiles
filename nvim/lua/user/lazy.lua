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
  { 'gregsexton/MatchTag' },
  { 'numToStr/Comment.nvim' },
  { 'tpope/vim-sleuth' },
  { 'simeji/winresizer' },
  { 'kana/vim-textobj-user' },
  { 'sgur/vim-textobj-parameter', dependencies = { 'kana/vim-textobj-user' } },
  {
    'shellRaining/hlchunk.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = false,
          style = "#81A1C1",
        },
        indent = {
          enable = true,
        },
        line_num = {
          enable = true,
          style = "#81A1C1",
        },
      })
    end,
  },
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end
  },
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup{}
    end
  },
  {
    'monaqa/dial.nvim',
    dependencies= { 'nvim-lua/plenary.nvim' },
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group{
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.constant.alias.bool,
          augend.constant.new{
            elements = {'and', 'or'},
            word = true,
            cyclic = true,
          },
          augend.constant.new{
            elements = {'&&', '||'},
            word = false,
            cyclic = true,
          },
          augend.constant.new{
            elements = {'True', 'False'},
            word = true,
            cyclic = true,
          },
        },
      }
      local dial_increment = function()
        require('dial.map').manipulate('increment', 'normal')
      end
      local dial_decrement = function()
        require('dial.map').manipulate('decrement', 'normal')
      end

      vim.keymap.set('n', '>', dial_increment)
      vim.keymap.set('n', '<S-Up>', dial_increment)
      vim.keymap.set('n', '<', dial_decrement)
      vim.keymap.set('n', '<S-Down>', dial_decrement)
    end
  },
  { 'endaaman/vim-case-master', config = function()
    vim.keymap.set('n', '<C-e>', ':<C-u>CaseMasterRotateCase<CR>')
    vim.keymap.set('v', '<C-e>', ':<C-u>CaseMasterRotateCaseVisual<CR>')
  end},
  -- { 'Yggdroot/indentLine' },
  -- { 'itchyny/vim-cursorword' },
  -- { 'tpope/vim-commentary' },
  -- { 'tpope/vim-surround' },

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
  require('plugins.copilot'),
})
