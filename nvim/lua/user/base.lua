vim.opt.encoding = 'utf-8'

local columns = vim.opt.columns:get()
local lines = vim.opt.lines:get()
vim.cmd('set all&')
vim.opt.columns = columns
vim.opt.lines = lines

-- Basic settings
vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.backspace = 'indent,eol,start'
vim.opt.backupdir = '~/.cache/vim'
vim.opt.completeopt:remove('preview')
vim.opt.conceallevel = 0
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.directory = '~/.cache/vim'
vim.opt.expandtab = true
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
vim.opt.history = 10000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 2
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.matchpairs:append('<:>')
vim.opt.matchtime = 1
vim.opt.modifiable = true
vim.opt.mouse = 'a'
vim.opt.backup = false
vim.opt.foldenable = false
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.ruler = true
vim.opt.scrolloff = 15
vim.opt.shell = vim.env.SHELL
vim.opt.shiftwidth = 2
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.smartcase = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.switchbuf = 'usetab'
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.timeout = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 50
vim.opt.undodir = '~/.cache/vim'
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wildmenu = true
vim.opt.wrap = true
vim.opt.write = true

vim.opt.clipboard = 'unnamedplus'
vim.opt.showbreak = '↳'
vim.opt.listchars = 'tab:\\ ,trail:-,eol:↲,extends:»,precedes:«,nbsp:%'

-- Global variables
vim.g.netrw_home = '~/.cache/vim'
vim.g.vim_indent_cont = vim.opt.shiftwidth:get()
vim.g.tex_conceal = ""

-- Neovim specific settings
if vim.fn.has('nvim') == 1 then
  vim.g.python3_host_prog = vim.fn.findfile('FindPythonWithPynvim')
  vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
end

vim.g.clipboard = {
  name = 'xsel',
  copy = {
    ['+'] = {'xsel', '--nodetach', '-i', '-b'},
    ['*'] = {'xsel', '--nodetach', '-i', '-p'},
  },
  paste = {
    ['+'] = {'xsel', '-o', '-b'},
    ['*'] = {'xsel', '-o', '-p'},
  },
  cache_enabled = 1,
}


local cursor_group = vim.api.nvim_create_augroup('CursorSettings', { clear = true })
vim.api.nvim_create_autocmd('InsertLeave', {
  group = cursor_group,
  callback = function()
    vim.opt.cursorline = true
    vim.opt.cursorcolumn = true
  end
})

vim.api.nvim_create_autocmd('InsertEnter', {
  group = cursor_group,
  callback = function()
    vim.opt.cursorline = false
    vim.opt.cursorcolumn = false
  end
})


vim.api.nvim_create_autocmd('InsertLeave', {
  group = cursor_group,
  callback = function()
    vim.opt.paste = false
  end
})
