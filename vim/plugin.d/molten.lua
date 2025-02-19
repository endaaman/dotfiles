require('image').setup({
  processor = "magick_cli",
})

-- Moltenの基本設定
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_show_exec_time = true
vim.g.molten_use_border_highlights = true  -- 実行状態によって境界線の色を変更
vim.g.molten_wrap_output = true           -- 長い出力を折り返す
vim.g.molten_auto_define_cells = true
vim.g.molten_auto_image_popup = false
vim.g.molten_auto_open_output = false       -- ポップアップ出力を自動表示しない
vim.g.molten_virt_text_output = true        -- 仮想テキスト出力を有効化
vim.g.molten_output_win_hide_on_leave = true -- セルを離れた時にポップアップを閉じる
vim.g.molten_virt_lines_off_by_1 = true     -- 仮想テキスト表示のズレを修正
vim.g.molten_cover_empty_lines = true       -- 端末環境でのズレを考慮


local quarto = require('quarto')
quarto.setup()
vim.keymap.set('n', '<leader>qp', quarto.quartoPreview, { silent = true, noremap = true })
