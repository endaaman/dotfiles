-- root (sudo n) では NVIM_MINIMAL=1 が渡る。安全のため uid 0 も最小扱い。
local minimal = vim.env.NVIM_MINIMAL == '1' or (vim.uv or vim.loop).getuid() == 0

require('user.base')
require('user.keymaps')
if not minimal then
  require('user.lazy')
end
