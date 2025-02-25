-- ~/.config/nvim/lua/custom/tmux_hooks.lua
local M = {}

-- 前回のtmuxウィンドウID
local last_window_id = nil

-- tmuxウィンドウ変更時に呼び出される関数
function M.on_window_change()
  vim.notify("Window changed", vim.log.levels.INFO)
  local utils = require("image/utils")
  local current_window_id = utils.tmux.get_window_id()

  -- 初回実行時またはウィンドウが変わった場合
  if not last_window_id then
    last_window_id = current_window_id
    return
  end

  -- ウィンドウが変わった場合のみ画像をクリア
  if current_window_id ~= last_window_id then
    M.clear_images()
    last_window_id = current_window_id
  end
end

-- 画像クリア処理
function M.clear_images()
  local image = require("image")
  local images = image.get_images()
  for _, img in ipairs(images) do
    img:clear()
    -- img:move(10, 10)
  end
  vim.cmd("redraw!")
end

-- ユーザーコマンドの設定
vim.api.nvim_create_user_command("TmuxClearImages", function()
  vim.notify("TmuxClearImages", vim.log.levels.INFO)
  M.clear_images()
end, {
  desc = "Clear all images (useful for tmux integration)"
})

-- 初期化時に実行
local function setup()
  -- 現在のtmuxウィンドウIDを取得
  local utils = require("image/utils")
  last_window_id = utils.tmux.get_window_id()
end

-- 自動セットアップ
-- setup()

return M
