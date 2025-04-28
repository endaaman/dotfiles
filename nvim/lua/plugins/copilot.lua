return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    cond = function()
      return vim.env.ENDAAMAN_ENABLE_COPILOT
    end,
    config = function()
      require('copilot').setup({
        suggestion = {
          enabled = true,
          auto_trigger = false,
          -- keymap = {
          --   accept = '<CR>',
          --   next = '<C-j>',
          --   prev = '<C-b>',
          --   dismiss = '<Esc>',
          -- }
        }
      })
      local suggestion = require('copilot.suggestion')
      vim.keymap.set('i', '<C-f>', function()
        suggestion.next()
      end)
      vim.keymap.set('i', '<C-b>', function()
        suggestion.prev()
      end)

      vim.keymap.set('i', '<Tab>', function()
        if suggestion.is_visible() then
          suggestion.accept_line()
          return ''
        end
        return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
      end, { expr=true })

      vim.keymap.set('i', '<C-j>', function()
        if suggestion.is_visible() then
          suggestion.accept()
          return ''
        end
        return vim.api.nvim_replace_termcodes('<C-j>', true, false, true)
      end, { expr=true })

    end,
  },
  {
    'yetone/avante.nvim',
    lazy = true,
    event = 'VeryLazy',
    cond = function()
      return vim.env.ENDAAMAN_ENABLE_COPILOT
    end,
    version = false, -- Never set this value to "*"! Never!
    opts = {

      -- provider = "openai",
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },
      hints = { enabled = false },
      provider = 'copilot',
      auto_suggestions_provider = 'copilot',
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
      },

    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'echasnovski/mini.pick',              -- for file_selector provider mini.pick
      'nvim-telescope/telescope.nvim',      -- for file_selector provider telescope
      'hrsh7th/nvim-cmp',                   -- autocompletion for avante commands and mentions
      'ibhagwan/fzf-lua',                   -- for file_selector provider fzf
      'nvim-tree/nvim-web-devicons',        -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua',
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  }
}
