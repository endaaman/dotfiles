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

-- ENDAAMAN_LEGACY=1: truecolor も Nerd Font も無いターミナル向け。
-- iceberg.nvim は gui の色しか持たないので、256 色の定義がある本家 iceberg.vim に切り替える
local legacy = vim.env.ENDAAMAN_LEGACY == '1'

return {
  { 'nvim-tree/nvim-web-devicons', enabled = not legacy },
  'tinted-theming/tinted-vim',
  {
    'RRethy/base16-nvim',
    config = function()
      -- vim.cmd.colorscheme 'base16-tomorrow-night'
    end
  },
  {
    'cocopon/iceberg.vim',
    enabled = legacy,
    config=function()
      vim.cmd.colorscheme 'iceberg'
    end,
  },
  {
    'oahlen/iceberg.nvim',
    enabled = not legacy,
    config=function()
      vim.cmd.colorscheme 'iceberg-dark'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      -- 'RRethy/base16-nvim',
    },
    config = function()
      local theme = require('lualine.themes.iceberg_dark')
      theme.normal.c.bg = '#1b1f26'

      require('lualine').setup({
        options = {
          icons_enabled = not legacy,
          -- theme = 'jellybeans',
          theme = theme,
          -- theme = 'iceberg_dark',
          -- theme = 'tomorrow-night',
          -- component_separators = { left = '', right = ''},
          -- section_separators   = { left = '', right = ''},
          -- section_separators   =  { left = '', right = '' },
          -- component_separators =  { left = '', right = '' },
          section_separators   = legacy and { left = '', right = '' } or { left= '', right= '' },
          component_separators = legacy and { left = '|', right = '|' } or { left= '', right= '' },
        },
        extensions = {
          fern_extension,
          'quickfix'
        }
      })
    end
  },
}
