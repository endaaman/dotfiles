local enabled = vim.env.ENDAAMAN_ENABLE_COPILOT


return {
  {
    'zbirenbaum/copilot.lua',
    lazy = true,
    cmd = 'Copilot',
    event = 'InsertEnter',
    enabled = enabled,
    opts = {
      model = 'claude-3.7-sonnet',
      debug = true,
    },
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
        },
        copilot_model = "",
      })
      local suggestion = require('copilot.suggestion')
      vim.keymap.set('i', '<C-j>', function()
        suggestion.next()
      end)
      vim.keymap.set('i', '<C-k>', function()
        suggestion.prev()
      end)

      vim.keymap.set('i', '<Tab>', function()
        if suggestion.is_visible() then
          suggestion.accept_line()
          return ''
        end
        return vim.api.nvim_replace_termcodes('<Tab>', true, false, true)
      end, { expr=true })

      vim.keymap.set('i', '<C-f>', function()
        if suggestion.is_visible() then
          suggestion.accept()
          return ''
        end
        return vim.api.nvim_replace_termcodes('<C-j>', true, false, true)
      end, { expr=true })
    end,
  },
  -- Deps for avante
  { 'MunifTanjim/nui.nvim', enabled = enabled, },
  { 'stevearc/dressing.nvim', enabled = enabled, },
  { 'echasnovski/mini.pick', enabled = enabled, },
  { 'ibhagwan/fzf-lua', enabled = enabled, },
  {
    'HakonHarnes/img-clip.nvim',
    enabled = enabled,
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
    'MeanderingProgrammer/render-markdown.nvim',
    enabled = enabled,
    -- opts = {
    --   file_types = { 'markdown', 'Avante' },
    -- },
    -- ft = { 'markdown', 'Avante' },
    ft = { 'Avante' },
    config = function(_, opts)
      local render_markdown = require('render-markdown')
      render_markdown.setup(opts)

      -- Add command to manually toggle markdown rendering
      vim.api.nvim_create_user_command('ToggleMarkdownRender', function()
        -- Check if current buffer is markdown
        if vim.bo.filetype == 'markdown' then
          -- Toggle rendering for current buffer
          if vim.b.markdown_render_enabled then
            render_markdown.disable_for_buffer()
            vim.b.markdown_render_enabled = false
            print('Markdown rendering disabled')
          else
            render_markdown.enable_for_buffer()
            vim.b.markdown_render_enabled = true
            print('Markdown rendering enabled')
          end
        else
          print('Not a markdown buffer')
        end
      end, {})

      -- Optional: Add keybinding for the toggle command
      vim.keymap.set('n', '<leader>mr', ':ToggleMarkdownRender<CR>',
        { noremap = true, silent = true, desc = "Toggle Markdown Rendering" })
    end,
  },
  {
    'yetone/avante.nvim',
    lazy = true,
    event = 'VeryLazy',
    cond = function() return enabled end,
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
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'zbirenbaum/copilot.lua',
      'MunifTanjim/nui.nvim',
      'stevearc/dressing.nvim',
      'echasnovski/mini.pick',
      'ibhagwan/fzf-lua',
      'HakonHarnes/img-clip.nvim',
      'MeanderingProgrammer/render-markdown.nvim',
    }
  }
}
