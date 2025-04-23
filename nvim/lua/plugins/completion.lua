
function config()
  local lspconfig = require('lspconfig')
  local root_pattern = require('lspconfig.util').root_pattern

  lspconfig.jedi_language_server.setup {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', '<space>K', vim.lsp.buf.definition, opts)
      -- vim.keymap.set('n', '<space>I', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>I', require('telescope.builtin').lsp_references, {})
      vim.keymap.set('n', '<C-o>', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', '<space>C', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', '<space>M', vim.lsp.buf.rename, opts)

      vim.keymap.set('n', '<C-f>', vim.diagnostic.goto_next)
      vim.keymap.set('n', '<C-b>', vim.diagnostic.goto_prev)

      vim.o.completeopt = 'menu,menuone,noselect'
    end,
    root_dir = root_pattern('pyproject.toml', '.git'),
    -- root_dir = function(fname)
    --   -- provide root dir
    --   return vim.fn.getcwd()
    -- end,
    -- cmd_env = {
    --   PYTHONPATH = vim.fn.getcwd()
    -- },
  }

  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local cmp = require('cmp')

  cmp.setup({
    root_markers = { 'pyproject.toml', '.git' },
    search_from_root = true,
    snippet = {
      expand = function(args)
      end,
    },
    mapping = {
      ['<C-o>'] = cmp.mapping.complete(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      {
        name = 'path',
        option = {
          get_cwd = function()
            return vim.fn.systemlist('git rev-parse --show-toplevel')[1]
          end
        }
      }
    },
  })
end

return {
  { 'neovim/nvim-lspconfig', config=config},
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  -- 'jmbuhr/otter.nvim',
}
