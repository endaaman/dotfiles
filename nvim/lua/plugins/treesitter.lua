vim.g.skip_ts_context_commentstring_module = true

local function config()
  local status, ts = pcall(require, 'nvim-treesitter.configs')
  if (not status) then return end

  ts.setup({
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
      'javascript', 'typescript', 'tsx',
      'css', 'html', 'scss', 'svelte',
      'json', 'yaml', 'toml',
      'python', 'lua', 'php', 'swift',
      'fish', 'vim', 'bash'
    },
    autotag = {
      enable = true,
    },
    textobjects = {
      move = {
        enable = true,
        set_jumps = false, -- you can change this if you want.
        goto_next_start = {
            --- ... other keymaps
            ["]b"] = { query = "@code_cell.inner", desc = "next code block" },
        },
        goto_previous_start = {
            --- ... other keymaps
            ["[b"] = { query = "@code_cell.inner", desc = "previous code block" },
        },
      },
      select = {
        enable = true,
        lookahead = true, -- you can change this if you want
        keymaps = {
          --- ... other keymaps
          ["ib"] = { query = "@code_cell.inner", desc = "in block" },
          ["ab"] = { query = "@code_cell.outer", desc = "around block" },
        },
      },
      swap = {
        -- Swap only works with code blocks that are under the same
        -- markdown header
        enable = true,
        swap_next = {
          --- ... other keymap
          ["<leader>sbl"] = "@code_cell.outer",
        },
        swap_previous = {
          --- ... other keymap
          ["<leader>sbh"] = "@code_cell.outer",
        },
      },
    }
  })

  local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
  parser_config.tsx.filetype_to_parsername = { 'javascript', 'typescript.tsx' }
  -- require('ts_context_commentstring').setup {}
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    config=config,
    build = ":TSUpdate",
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
}
