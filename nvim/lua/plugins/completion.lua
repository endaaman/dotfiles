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

  -- Python LSP (jedi-language-server)
  if vim.fn.executable('jedi-language-server') == 1 then
    vim.lsp.config.jedi_language_server = {
      cmd = { 'jedi-language-server' },
      filetypes = { 'python' },
      root_markers = { 'pyproject.toml', '.git' },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
    }
    vim.lsp.enable('jedi_language_server')
  end

  -- Lua LSP (lua-language-server)
  if vim.fn.executable('lua-language-server') == 1 then
    vim.lsp.config.lua_ls = {
      cmd = { 'lua-language-server' },
      filetypes = { 'lua' },
      root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {'vim'},
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
    vim.lsp.enable('lua_ls')
  end

  -- Go LSP (gopls)
  if vim.fn.executable('gopls') == 1 then
    vim.lsp.config.gopls = {
      cmd = { 'gopls' },
      filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
      root_markers = { 'go.mod', '.git' },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
    vim.lsp.enable('gopls')
  end

  -- TypeScript LSP (typescript-language-server)
  if vim.fn.executable('typescript-language-server') == 1 then
    vim.lsp.config.ts_ls = {
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
      root_markers = { 'package.json', 'tsconfig.json', '.git' },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
    }
    vim.lsp.enable('ts_ls')
  end

  -- Svelte LSP (svelteserver)
  if vim.fn.executable('svelteserver') == 1 then
    vim.lsp.config.svelte = {
      cmd = { 'svelteserver', '--stdio' },
      filetypes = { 'svelte' },
      root_markers = { 'svelte.config.js', 'package.json' },
      capabilities = vim.lsp.protocol.make_client_capabilities(),
      on_attach = on_attach,
      settings = {
        svelte = {
          plugin = {
            svelte = {
              compilerWarnings = {
                -- a11yの警告をすべて無視
                ["a11y-*"] = "ignore",
              }
            }
          }
        }
      }
    }
    vim.lsp.enable('svelte')
  end

  -- Emmet LSP (emmet-ls)
  if vim.fn.executable('emmet-ls') == 1 then
    vim.lsp.config.emmet_ls = {
      cmd = { 'emmet-ls', '--stdio' },
      filetypes = { 'html', 'svelte', 'vue', 'javascriptreact', 'typescriptreact' },
      root_markers = { '.git' },
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        html = {
          options = {
            ["bem.enabled"] = true,
          },
        },
      }
    }
    vim.lsp.enable('emmet_ls')
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
