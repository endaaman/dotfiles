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
        'markdown',
        'markdown_inline',
        -- 'python',
      },
    },
    indent = {
      enable = true,
      disable = {
        'python',
      },
    },
  })


  local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
  parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }

  require('nvim-ts-autotag').setup()
  -- require('ts_context_commentstring').setup {}
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.treesitter.stop()
  end,
})

local enabled = vim.fn.executable('tree-sitter') == 1

return {
  {
    'nvim-treesitter/nvim-treesitter',
    config = config,
    enabled = enabled,
  },
  -- {
  --   'nvim-treesitter/nvim-treesitter-context',
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   enabled = enabled,
  --   opts = {
  --     enable = true,
  --     on_attach = function(buf)
  --       return vim.bo[buf].filetype ~= 'markdown'
  --     end,
  --   },
  -- },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
