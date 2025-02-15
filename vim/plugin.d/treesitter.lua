vim.g.skip_ts_context_commentstring_module = true

local status, ts = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {
      'json',
    },
  },
  indent = {
    enable = true,
    disable = {
      'python',
    },
  },
  ensure_installed = {
    'javascript',
    'typescript',
    'tsx',
    'toml',
    'fish',
    'php',
    'json',
    'yaml',
    'swift',
    'css',
    'scss',
    'html',
    'lua',
    'python',
    'svelte',
  },
  autotag = {
    enable = true,
  },
}

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

-- require('ts_context_commentstring').setup {}
