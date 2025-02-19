-- LSP設定
local lspconfig = require('lspconfig')

-- Jedi言語サーバーの設定
lspconfig.jedi_language_server.setup {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
  on_attach = function(client, bufnr)
    -- キーマッピング
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', '<space>K', vim.lsp.buf.definition, opts)
    -- vim.keymap.set('n', '<space>I', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>I', require('telescope.builtin').lsp_references, {})
    vim.keymap.set('n', '<C-o>', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>C', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>M', vim.lsp.buf.rename, opts)
  end
}

-- LSP診断表示の設定（オプション）
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
