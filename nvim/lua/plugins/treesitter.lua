vim.g.skip_ts_context_commentstring_module = true

local function config()
  local ts = require('nvim-treesitter.configs')

  ts.setup({
    sync_install = false,
    auto_install = true,
    ensure_installed = {
      'javascript', 'typescript', 'tsx',
      'css', 'html', 'scss', 'svelte', 'markdown',
      'json', 'yaml', 'toml',
      'python', 'lua', 'php', 'swift',
      'fish', 'vim', 'bash',
    },
    ignore_install = {},
    modules = {},

    highlight = {
      enable = true,
      disable = {
        'json',
        -- 'python',
      },
    },
    indent = {
      enable = true,
      disable = {
        'python',
      },
    },

    autotag = {
      enable = true,
    },
  })

  local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
  parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
  -- require('ts_context_commentstring').setup {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config=config,
    build = ':TSUpdate',
  },
}
