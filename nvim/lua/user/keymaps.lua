function _G.IndentWithI()
  if #vim.fn.getline('.') == 0 then
    return '"_cc'
  else
    return 'i'
  end
end

function _G.SearchByRegister()
  local reg_content = vim.fn.getreg('+')
  local splitted = vim.split(reg_content, '\n')
  if #splitted > 0 then
    vim.fn.setreg('/', splitted[1])
    return 'n'
  else
    return ''
  end
end

if not vim.g.markrement_char then
  vim.g.markrement_char = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  }
end

function _G.AutoMarkrement()
  if not vim.b.markrement_pos then
    vim.b.markrement_pos = 0
  else
    vim.b.markrement_pos = (vim.b.markrement_pos + 1) % #vim.g.markrement_char
  end
  vim.cmd('mark ' .. vim.g.markrement_char[vim.b.markrement_pos + 1])
  print('marked ' .. vim.g.markrement_char[vim.b.markrement_pos + 1])
end

-- レジスタをシフト
function _G.ShiftRegister()
  local clipboard
  if vim.o.clipboard:match('unnamedplus') then
    clipboard = vim.fn.getreg('+')
  elseif vim.o.clipboard:match('unnamed') then
    clipboard = vim.fn.getreg('*')
  else
    clipboard = vim.fn.getreg('"')
  end

  if clipboard == '' or clipboard == '\n' then
    return
  end

  local list = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'}
  if vim.fn.getreg('a') ~= clipboard then
    for i = #list, 1, -1 do
      local content = i == 1 and clipboard or vim.fn.getreg(list[i - 1])
      vim.fn.setreg(list[i], content, 'v')
    end
  end
end

-- レジスタプレフィックス
function _G.RegisterPrefix(key)
  _G.ShiftRegister()
  return '"' .. vim.v.register .. key
end


vim.keymap.set({ 'n', 'v' }, '<Space>j', 'J')
vim.keymap.set({ 'n', 'v' }, '<Space>i', ':<C-u>vs<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>-', ':<C-u>sp<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>e', ':<C-u>e!<CR><C-l>')
vim.keymap.set({ 'n', 'v' }, '<Space><C-l>', '<C-l>')
vim.keymap.set({ 'n', 'v' }, '<Space>T', ':<C-u>terminal<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>t', '<C-w>v<C-w>w:<C-u>terminal<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space><C-p>', '<C-w>v<C-w>w:<C-u>terminal ipython<CR><C-\\><C-n><C-w>p')
vim.keymap.set({ 'n', 'v' }, '<Space>q', ':<C-u>:q!<CR>')
vim.keymap.set('n', '<Space>/', 'v:lua.SearchByRegister()', { expr = true })


vim.keymap.set({ 'n', 'v' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v' }, 'k', 'gk')
vim.keymap.set({ 'n', 'v' }, 'J', '<C-d>zz')
vim.keymap.set({ 'n', 'v' }, 'K', '<C-u>zz')
vim.keymap.set({ 'n', 'v' }, 'H', 'g^')
vim.keymap.set({ 'n', 'v' }, 'L', 'g$')

vim.keymap.set({ 'n', 'v' }, 'x', '"_x')
vim.keymap.set({ 'n', 'v' }, 'X', '"_D')
vim.keymap.set({ 'n', 'v' }, 's', '"_s')
vim.keymap.set('n', 'S', '"_S')
vim.keymap.set({ 'n', 'v' }, 'n', 'nzz')
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzz')
vim.keymap.set({ 'n', 'v' }, 'G', 'Gzz')

vim.keymap.set('n', 'i', 'v:lua.IndentWithI()', { expr = true })
vim.keymap.set('n', '*', ':<C-u>let @/=expand("<cword>")|set hlsearch<CR>')
vim.keymap.set('n', '<Space>w', ':<C-u>let @/=expand("<cword>")|set hlsearch<CR>')
vim.keymap.set('n', '#', '#zz')
vim.keymap.set('n', 'o', 'o<Esc>')
vim.keymap.set('n', 'O', 'O<Esc>')
vim.keymap.set('n', 'p', 'p`]')
vim.keymap.set('n', 'M', ':<C-u>lua AutoMarkrement()<CR>')
vim.keymap.set('n', '<S-Down>', '<C-x>')
vim.keymap.set('n', '<S-Up>', '<C-a>')
vim.keymap.set('n', '-', '<C-x>')
vim.keymap.set('n', '+', '<C-a>')
vim.keymap.set('n', '<Tab>', '<C-w>w')
vim.keymap.set('n', '<S-Tab>', '<C-w>W')

-- vim.keymap.set('n', '<CR>', 'yy')  -- コメントアウト
-- vim.keymap.set('v', '<CR>', 'y')   -- コメントアウト
vim.keymap.set('n', '<CR>', "v:lua.RegisterPrefix('yy')", { expr = true, silent = true })

vim.keymap.set({ 'n', 'v' }, 'y', "v:lua.RegisterPrefix('y')", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'd', "v:lua.RegisterPrefix('d')", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'c', "v:lua.RegisterPrefix('c')", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'Y', "v:lua.RegisterPrefix('Y')", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'D', "v:lua.RegisterPrefix('D')", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'C', "v:lua.RegisterPrefix('C')", { expr = true, silent = true })
vim.keymap.set('n', 'yy', "v:lua.RegisterPrefix('yy')", { expr = true, silent = true })
vim.keymap.set('n', 'dd', "v:lua.RegisterPrefix('dd')", { expr = true, silent = true })
vim.keymap.set('n', '<C-m>', "v:lua.RegisterPrefix('yy')", { expr = true, silent = true })
vim.keymap.set('v', '<C-m>', "v:lua.RegisterPrefix('y')", { expr = true, silent = true })
vim.keymap.set('o', '<C-m>', "v:lua.RegisterPrefix('y')", { expr = true, silent = true })



vim.keymap.set('n', '<C-u>', ':<C-u>noh<CR><C-l>')
vim.keymap.set('n', '<C-q>', ':<C-u>qa<CR>')
vim.keymap.set('n', '<C-d>', ':<C-u>q<CR>')
vim.keymap.set('n', '<C-x>', ':<C-u>x<CR>')
vim.keymap.set('n', '<C-s>', ':<C-u>w<CR>')
vim.keymap.set('n', '<C-l>', '<C-i>')
vim.keymap.set('n', '<C-h>', '<C-o>')

vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('n', '<C-n>', 'gt')
vim.keymap.set('n', '<C-Tab>', 'gt')
vim.keymap.set('n', '<C-p>', 'gT')
vim.keymap.set('n', '<C-S-Tab>', 'gt')
vim.keymap.set('n', '<C-t>', ':<C-u>tabnew<CR>')
vim.keymap.set('n', '<S-Left>', ':tabm -1<CR>')
vim.keymap.set('n', '<S-Right>', ':tabm +1<CR>')


vim.keymap.set('v', 'v', '$h')
vim.keymap.set('v', '<Tab>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')
vim.keymap.set('v', 'y', 'y`]')
vim.keymap.set('v', 'p', '<C-[>:<C-u>let @z=@+<CR>gvp`]:let @+=@z<CR>')
vim.keymap.set('v', 'O', ':sort<CR>')
vim.keymap.set('v', 'R', 'c<C-O>:set revins<CR><C-R>"<Esc>:set norevins<CR>')
vim.keymap.set('v', '/', '"zy:<C-u>let @/=@z|set hlsearch<CR>')
vim.keymap.set('v', 'H', '^')
vim.keymap.set('v', 'L', '$')


vim.keymap.set('i', '<C-d>', '<Del>')

vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-e>', '<End>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-d>', '<Delete>')
