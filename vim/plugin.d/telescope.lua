local telescope = require('telescope')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
local builtin = require('telescope.builtin')
local sorters = require("telescope.sorters")

vim.keymap.set('n', '<Space>f', builtin.git_files, {})
vim.keymap.set('n', '<Space>g', builtin.live_grep, {})
vim.keymap.set('n', '<Space>o', builtin.oldfiles, {})
vim.keymap.set('n', '<Space>b', builtin.buffers, {})
vim.keymap.set('n', '<Space>h', builtin.help_tags, {})
vim.keymap.set('n', '<Space>d', builtin.git_status, {})
vim.keymap.set('n', '<Space><Space>', builtin.resume, {})


local default_maps = {
  n = {
    ['<Tab>'] = actions.move_selection_next,
    ['<S-Tab>'] = actions.move_selection_previous,
  },
  i = {
    ['<Tab>'] = actions.move_selection_next,
    ['<S-Tab>'] = actions.move_selection_previous,
    ['<Esc>'] = actions.close,
    ['<C-j>'] = actions.git_staging_toggle,
  },
}

telescope.setup{
  defaults = {
    -- generic_sorter = sorters.get_fzy_sorter,
    file_sorter = sorters.get_generic_fuzzy_sorter,
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
  },
}
