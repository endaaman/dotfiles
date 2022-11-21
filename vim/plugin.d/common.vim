
let g:precious_enable_switchers = {
\ '*' : {
\  'setfiletype' : 1
\ },
\ 'vue' : {
\  'setfiletype' : 0
\ },
\}

let g:context_filetype#search_offset = 10000
if !exists('g:context_filetype#filetypes')
  let g:context_filetype#filetypes = {}
endif

let g:context_filetype#filetypes.ipynb =
  \ [{
  \   'filetype' : 'python',
  \   'start' : '^# %%', 'end' : '\(^# %%\|\%$\)'
  \ }, {
  \   'filetype' : 'python',
  \   'start' : '\%^', 'end' : '\(^# %%\|\%$\)'
  \ }, {
  \   'filetype' : '\1',
  \   'start' : '^# %% \[\(\h\w*\)\]', 'end' : '\(^# %%\|\%$\)'
  \ }]



let g:vim_textobj_parameter_mapping = 'a'
let g:winresizer_start_key = '<Space>R'

# git-gutter
nnoremap <C-k> :<C-u>GitGutterPrevHunk<CR>
nnoremap <C-j> :<C-u>GitGutterNextHunk<CR>
autocmd EN BufWritePost * :GitGutter

" echodoc
set noshowmode
" set cmdheight=2
let g:echodoc#enable_at_startup = 1
" let g:echodoc#enable_force_overwrite = 1
