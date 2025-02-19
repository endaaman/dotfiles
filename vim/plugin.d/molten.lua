-- Setup image.nvim
-- require('image').setup()
require('image').setup({
  -- backend = "kitty",
  processor = "magick_cli",
})

-- Moltenの設定
vim.g.molten_image_provider = "image.nvim"
vim.g.molten_output_show_exec_time = true
-- vim.g.molten_output_win_border = { "", "━", "", "" }  -- 出力ウィンドウの境界線
-- vim.g.molten_output_win_max_height = 20    -- 出力ウィンドウの最大高さ
vim.g.molten_use_border_highlights = true  -- 実行状態によって境界線の色を変更

vim.g.molten_wrap_output = true           -- 長い出力を折り返す
vim.g.molten_auto_define_cells = true
vim.g.molten_auto_image_popup = false

vim.g.molten_auto_open_output = false       -- ポップアップ出力を自動表示しない
-- vim.g.molten_virt_text_output = false
vim.g.molten_virt_text_output = true        -- 仮想テキスト出力を有効化
vim.g.molten_output_win_hide_on_leave = true -- セルを離れた時にポップアップを閉じる


-- 仮想テキスト表示のズレを修正
vim.g.molten_virt_lines_off_by_1 = true
-- 端末環境でのズレを考慮
vim.g.molten_cover_empty_lines = true


-- セルの視覚的フィードバック強化
vim.api.nvim_set_hl(0, "MoltenCell", { link = "CursorLine" })  -- セルのハイライト

-- キーマッピング
vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",
    { silent = true, desc = "Jupyter kernelを初期化" })
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",
    { silent = true, desc = "選択部分を実行" })
vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",
    { silent = true, desc = "現在の行を実行" })
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",
    { silent = true, desc = "セルを再実行" })
vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",
    { silent = true, desc = "ビジュアル選択を実行" })


-- 自動定義セルの設定（これは公式には提供されていませんが、似た動作のためのワークアラウンド）
vim.api.nvim_create_autocmd("User", {
  pattern = "MoltenInitPost",
  callback = function()
    -- セルの境界を明確にする
    vim.api.nvim_set_hl(0, "MoltenCell", { bg = "#2a2a3a" })  -- セルの背景色を少し変える
  end,
})

function run_current_cell()
  local cursor_line = vim.fn.line('.')
  local buffer_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Find start of current cell
  local start_line = cursor_line
  while start_line > 1 and not buffer_lines[start_line-1]:match("^# %%%%") do
    start_line = start_line - 1
  end

  -- Find end of current cell
  local end_line = cursor_line
  while end_line < #buffer_lines and not buffer_lines[end_line+1]:match("^# %%%%") do
    end_line = end_line + 1
  end

  -- Visual select the cell
  vim.cmd(start_line .. "GV" .. end_line .. "G")
  -- Execute with Molten and maintain visual selection
  vim.cmd("MoltenEvaluateVisual")
end

-- Map to a key (optional)
vim.keymap.set("n", "<space>nx", run_current_cell,
  {desc = "Run current Jupyter cell with Molten", silent = true})
