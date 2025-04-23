
function config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local make_entry = require "telescope.make_entry"
  local action_layout = require('telescope.actions.layout')
  local builtin = require('telescope.builtin')
  local action_state = require('telescope.actions.state')
  local sorters = require('telescope.sorters')
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  vim.keymap.set('n', '<Space><Space>', builtin.resume, {})
  vim.keymap.set('n', '<Space>b', builtin.buffers, {})
  vim.keymap.set('n', '<Space>o', builtin.oldfiles, {})
  vim.keymap.set('n', '<Space>h', builtin.help_tags, {})
  vim.keymap.set('n', '<Space>g', builtin.live_grep, {})
  vim.keymap.set('n', '<Space>m', builtin.marks, {})
  -- vim.keymap.set('n', '<Space>f', builtin.git_files, {})
  vim.keymap.set('n', '<Space>d', builtin.git_status, {})
  vim.keymap.set('n', '<Space>r', builtin.registers, {})
  -- vim.keymap.set('n', '<Space>l', '<CMD>Telescope coc workspace_symbols<CR>', {})
  -- vim.keymap.set('n', '<Space>k', '<CMD>Telescope coc references_used<CR>', {})

  vim.keymap.set('n', '<Space>W', function()
    builtin.live_grep({ default_text=vim.fn.expand('<cword>') })
  end, {})

  vim.keymap.set('n', '<Space>G', function()
    local reg = vim.fn.getreg('+')
    local first = reg:gmatch("[^\r\n]+")()
    builtin.live_grep({ default_text=first })
  end, {})

  vim.keymap.set('n', '<Space>f', function()
    local ok = pcall(builtin.git_files)
    if not ok then
      builtin.find_files()
    end
  end, {})

  function clipboard(opts)
    local cmd
    if 1 == vim.fn.executable 'copyq' then
      cmd = { 'copyq', 'tab', 'clipboard', 'read' }
    elseif 1 == vim.fn.executable 'qdbus' then
      cmd = { 'qdbus', 'org.kde.klipper', '/klipper', 'org.kde.klipper.klipper.getClipboardHistoryMenu' }
      -- qdbus org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryItem 0
    else
      return 1
    end

    pickers
      .new(opts, {
        prompt_title = "Klipper",
        finder = finders.new_oneshot_job(
          cmd,
          opts
        ),
        -- previewer = conf.qflist_previewer(opts),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(v)
          actions.select_default:replace(function(bufnr)
            print(bufnr)
            local selection = action_state.get_selected_entry()
            if selection == nil then
              print('nil')
              utils.__warn_no_selection "actions.paste_register"
              return
            end
            print(vim.fn.printf('hi %s', selection.content))
            actions.close(bufnr)
          end)
          return true
        end,
      })
      :find()
  end

  vim.keymap.set('n', '<Space>c', clipboard, {})


  local default_maps = {
    n = {
      ['<Tab>'] = actions.move_selection_next,
      ['<S-Tab>'] = actions.move_selection_previous,
      ['<Del>'] = actions.remove_selection,
    },
    i = {
      ['<Tab>'] = actions.move_selection_next,
      ['<S-Tab>'] = actions.move_selection_previous,
      ['<Esc>'] = actions.close,
      ['<C-j>'] = actions.git_staging_toggle,
      ['<Del>'] = actions.remove_selection,
    },
  }

  telescope.setup{
    defaults = {
      -- generic_sorter = sorters.get_fzy_sorter,
      -- file_sorter = sorters.get_fzy_sorter,
      -- file_sorter = sorters.get_generic_fuzzy_sorter,
      sorting_strategy = 'ascending',
      layout_config = {
        prompt_position="top",
      },
      mappings = default_maps,
    },
    pickers = {
      git_status = {
        mappings = default_maps,
      },
      git_files = {
        git_command = {'git', 'ls-files', '--cached', '--others', '--exclude-standard'},
        -- git_command = {'ls'},
      },
    },

    extensions = {
      -- coc = {
      --     -- theme = 'ivy',
      --     -- always use Telescope locations to preview definitions/declarations/implementations etc
      --     prefer_locations = true,
      -- },
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    },
  }

  -- telescope.load_extension('coc')
  -- telescope.load_extension('fzf')
end


return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = config,
}
