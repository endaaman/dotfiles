vim.g.skip_ts_context_commentstring_module = true

local parsers = {
  'javascript', 'typescript', 'tsx',
  'css', 'html', 'scss', 'svelte', 'markdown', 'markdown_inline',
  'json', 'yaml', 'toml',
  'python', 'lua', 'php', 'swift',
  'fish', 'vim', 'vimdoc', 'bash',
}

local highlight_ft = {
  'javascript', 'typescript', 'tsx', 'javascriptreact', 'typescriptreact',
  'css', 'html', 'scss', 'svelte', 'markdown',
  'yaml', 'toml',
  'python', 'lua', 'php', 'swift',
  'fish', 'vim', 'help', 'bash', 'sh', 'zsh',
}

local indent_ft = {
  'javascript', 'typescript', 'tsx', 'javascriptreact', 'typescriptreact',
  'css', 'html', 'scss', 'svelte',
  'json', 'yaml', 'toml',
  'lua', 'php', 'swift',
  'vim', 'bash', 'sh',
}

local function config()
  require('nvim-treesitter').setup()
  require('nvim-treesitter').install(parsers)

  vim.api.nvim_create_autocmd('FileType', {
    pattern = highlight_ft,
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })

  vim.api.nvim_create_autocmd('FileType', {
    pattern = indent_ft,
    callback = function()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })

  require('nvim-ts-autotag').setup()
end

local enabled = vim.fn.executable('tree-sitter') == 1

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = config,
    enabled = enabled,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    enabled = enabled,
  },
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
}
