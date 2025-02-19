require("jupytext").setup({
  style = "markdown",
  output_extension = "md",
  force_ft = "markdown",
})
--
-- vim.g.jupytext_enable = 1

require("image").setup({
  processor = "magick_cli",
  clear_in_normal_mode = true,
  window_overlap_clear_enabled = true,
  tmux_show_only_in_active_window = true,
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

vim.g.molten_auto_open_output = false


local quarto = require("quarto")
quarto.setup({
  lspFeatures = {
    -- NOTE: put whatever languages you want here:
    languages = { "r", "python", "rust" },
    chunks = "all",
    diagnostics = {
      enabled = true,
      triggers = { "BufWritePost" },
    },
    completion = {
      enabled = true,
    },
  },

  codeRunner = {
    enabled = true,
    default_method = "molten",
  },
})
vim.keymap.set("n", "<space>Q", quarto.quartoPreview, { silent = true, noremap = true })

local runner = require("quarto.runner")
vim.keymap.set("n", "<space>nn", runner.run_cell,  { desc = "run cell", silent = true })
vim.keymap.set("n", "<space>na", runner.run_above, { desc = "run cell and above", silent = true })
vim.keymap.set("n", "<space>nA", runner.run_all,   { desc = "run all cells", silent = true })
vim.keymap.set("n", "<space>nl", runner.run_line,  { desc = "run line", silent = true })
vim.keymap.set("v", "<space>nn", runner.run_range, { desc = "run visual range", silent = true })
-- vim.keymap.set("n", "<space>RA", function() runner.run_all(true) end, { desc = "run all cells of all languages", silent = true })

quarto.activate()
