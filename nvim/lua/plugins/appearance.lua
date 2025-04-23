local fern_extension = {
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  filetypes = {'fern'}
}

vim.g.tinted_colorspace = 256

return {
  'nvim-tree/nvim-web-devicons',
  'tinted-theming/tinted-vim',
  {
    'cocopon/iceberg.vim',
    config=function()
      vim.cmd.colorscheme 'iceberg'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local theme = require('lualine.themes.iceberg_dark')
      theme.normal.c.bg = '#1b1f26'

      require('lualine').setup({
        options = {
          icons_enabled = true,
          -- theme = 'jellybeans',
          theme = theme,
          -- theme = 'iceberg_dark',
          -- theme = 'tomorrow-night',
          -- component_separators = { left = '', right = ''},
          -- section_separators   = { left = '', right = ''},
          -- section_separators   =  { left = '', right = '' },
          -- component_separators =  { left = '', right = '' },
          section_separators   = { left= '', right= '' },
          component_separators = { left= '', right= '' },
        },
        extensions = {
          fern_extension,
          'quickfix'
        }
      })
    end
  },
}
