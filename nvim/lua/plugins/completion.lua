local function definition_in_tab()
  local function on_list(options)
    vim.fn.setqflist({}, ' ', options)
    local item = options.items[1]
    if item then
      local current_filename = vim.fn.expand('%:p')
      if current_filename ~= item.filename then
        vim.cmd('tab drop ' .. item.filename)
      end
      vim.api.nvim_win_set_cursor(0, {item.lnum, item.col - 1})
    end
  end
  vim.lsp.buf.definition({on_list = on_list})
end

local function config()
  local lspconfig = require('lspconfig')
  local root_pattern = require('lspconfig.util').root_pattern
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local on_attach = function(client, bufnr)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.definition)
    vim.keymap.set('n', '<space>K', definition_in_tab)
    vim.keymap.set('n', '<space>I', vim.lsp.buf.references)
    vim.keymap.set('n', '<C-o>', vim.lsp.buf.hover)
    vim.keymap.set('n', '<space>M', vim.lsp.buf.code_action)
    vim.keymap.set('n', '<space>C', vim.lsp.buf.rename)

    vim.keymap.set('n', '<C-f>', function() vim.diagnostic.jump({count = 1, float = true}) end)
    vim.keymap.set('n', '<C-b>', function() vim.diagnostic.jump({count = -1, float = true}) end)

    vim.o.completeopt = 'menu,menuone,noselect'

    if vim.bo.filetype == 'javascript' then
      vim.diagnostic.enable(false)
    end
  end

  if vim.fn.executable('lua-language-server') == 1 then
    lspconfig.jedi_language_server.setup {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      root_dir = root_pattern('pyproject.toml', '.git'),
    }
  end

  if vim.fn.executable('jedi-language-server') == 1 then
    lspconfig.lua_ls.setup {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            lobals = {'vim'},
            disable = {
              'unused-local',
              'undefined-field',
              'duplicate-set-field',
            }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }
  end

  if vim.fn.executable('gopls') == 1 then
    lspconfig.gopls.setup {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      root_dir = root_pattern('go.mod', '.git'),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
  end

  if vim.fn.executable('typescript-language-server') == 1 then
    lspconfig.ts_ls.setup {
      -- filetypes = { "typescript", },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      root_dir = root_pattern('package.json', 'tsconfig.json', '.git'),
    }
  end

  if vim.fn.executable('svelteserver') == 1 then
    lspconfig.svelte.setup {
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      root_dir = lspconfig.util.root_pattern('svelte.config.js', 'package.json')
    }
  end

  if vim.fn.executable('emmet-ls') == 1 then
    lspconfig.emmet_ls.setup({
      capabilities = capabilities,
      filetypes = { 'html', 'svelte', 'vue', 'javascriptreact', 'typescriptreact' },
      init_options = {
        html = {
          options = {
            ["bem.enabled"] = true,
          },
        },
      }
    })
  end

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
      ['<C-space>'] = cmp.mapping.complete(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        -- behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'html' },
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
