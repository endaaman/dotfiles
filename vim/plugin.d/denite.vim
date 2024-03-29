finish
autocmd FileType denite let b:deoplete_disable_auto_complete = 1
autocmd FileType denite-filter let b:deoplete_disable_auto_complete = 1

nnoremap <Space>O :<C-u>Denite outline<CR>
nnoremap <Space>o :<C-u>Denite file/old<CR>
nnoremap <Space>J :<C-u>Denite jump<CR>
nnoremap <Space>b :<C-u>Denite buffer<CR>
nnoremap <Space>m :<C-u>Denite mark<CR>
nnoremap <Space>M :<C-u>Denite menu<CR>
nnoremap <Space>g :<C-u>Denite grep -no-empty<CR>
nnoremap <Space>G :<C-u>Denite grep -input=`@0`<CR>
nnoremap <Space>? :<C-u>Denite grep -input=`@/`<CR>
nnoremap <Space>W :<C-u>DeniteCursorWord grep -no-empty<CR>
nnoremap <Space>c :<C-u>Denite command_history<CR>
nnoremap <Space>C :<C-u>Denite colorscheme<CR>
nnoremap <Space>p :<C-u>Denite my/clipboard<CR>
nnoremap <Space>P :<C-u>Denite my/clipboard -default-action=prepend<CR>
nnoremap <Space>r :<C-u>Denite my/clipboard -default-action=yank<CR>
nnoremap <Space>d :<C-u>Denite my/git/status<CR>
nnoremap <Space>f :<C-u>Denite `finddir('.git', ';') != '' ? 'my/git/all' : 'file/rec'`<CR>
nnoremap <Space>F :<C-u>DeniteCursorWord `finddir('.git', ';') != '' ? 'my/git/all' : 'file/rec'`<CR>
nnoremap <Space>y :<C-u>Denite menu:yank<CR>
nnoremap <Space>, :<C-u>Denite file/rec -path=,<CR>
nnoremap <Space>a :<C-u>DeniteBufferDir file/rec<CR>
nnoremap <Space>A :<C-u>Denite directory_rec<CR>
nnoremap <Space>H :<C-u>Denite help -default-action=tabopen<CR>
nnoremap <Space>L :<C-u>Denite my/git/log<CR>
nnoremap <Space><C-f> :<C-u>Denite -resume -cursor-pos=+1 -immediately<CR>
nnoremap <Space><C-b> :<C-u>Denite -resume -cursor-pos=-1 -immediately<CR>
nnoremap <Space><Space> :<C-u>Denite -resume<CR>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <Esc> denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Tab> 'j'
  nnoremap <silent><buffer><expr> <S-Tab> 'k'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  inoremap <silent><buffer><expr> <Esc> denite#do_map('quit')

  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  " inoremap <silent><buffer> <Tab> <Esc><C-w>p:call cursor(line('.')+1,1)<CR><C-w>pA
  " inoremap <silent><buffer> <S-Tab> <Esc><C-w>p:call cursor(line('.')-1,1)<CR><C-w>pA
  inoremap <silent><buffer><expr> <Tab> denite#increment_parent_cursor(1)
  inoremap <silent><buffer><expr> <S-Tab> denite#increment_parent_cursor(-1)

  inoremap <silent><buffer> <C-a> <Home>
  inoremap <silent><buffer> <C-e> <End>
  inoremap <silent><buffer> <C-d> <Delete>
  inoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'split')
  inoremap <silent><buffer><expr> <C-j> denite#do_map('choose_action')
endfunction


 let s:menus = {}
 let s:menus.yank = { 'description': 'Yank file name or path' }
 let s:menus.yank.command_candidates = [
   \ ['File name', 'call YankFileName()'],
   \ ['Relative path', 'call YankRelativePath()'],
   \ ['Full path', 'call YankFullPath()'],
   \ ]
 let s:menus.CaseMaster = { 'description': 'Convert word case style' }
 let s:menus.CaseMaster.command_candidates = [
   \ ['To snake_case', 'CaseMasterConvertToSnake'],
   \ ['To kebab-case', 'CaseMasterConvertToKebab'],
   \ ['To camelCase', 'CaseMasterConvertToCamel'],
   \ ['To PascalCase', 'CaseMasterConvertToPascal'],
   \ ]
 let s:menus.Highlight = { 'description': 'Check highlight' }
 let s:menus.Highlight.command_candidates = [
   \ ['Highlight test', 'so $VIMRUNTIME/syntax/hitest.vim | execute "normal \<C-w>\T"'],
   \ ['Color test', 'so $VIMRUNTIME/syntax/colortest.vim | execute "normal \<C-w>\T"'],
   \ ]
 call denite#custom#var('menu', 'menus', s:menus)
 call denite#custom#action('command', 'tabopen', 'DeniteActionTabopen')
 call denite#custom#action('command', 'quit_if_empty_or_delete', 'DeniteActionQuitIfEmptyOrDelete')

 call denite#custom#source('_', 'matchers', ['matcher/regexp', 'matcher/substring'])

 call denite#custom#option('_', { 'highlight_matched_char': 'Title' })
 if get(g:, 'rich')
   call denite#custom#option('_', 'prompt', '')
 endif
 call denite#custom#option('_', 'start_filter', 1)

 call denite#custom#alias('source', 'my/git/all', 'file/rec')
 call denite#custom#var('my/git/all', 'command',
   \ ['git', 'ls-files', '--cached', '--others', '--exclude-standard'])

call denite#custom#filter('matcher/ignore_globs', 'ignore_globs', [
   \ '*~', '*.o', '*.exe', '*.bak',
   \ '.DS_Store', '*.pyc', '*.sw[po]', '*.class',
   \ '.hg/', '.git/', '.bzr/', '.svn/',
   \ 'tags', 'tags-*',
   \ 'node_modules/', '*.ttf', 'vendor/', '*.pyc'
   \ ])

 if executable('ag')
   call denite#custom#var('file/rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
   call denite#custom#var('grep', 'command', ['ag'])
   call denite#custom#var('grep', 'default_opts', ['--vimgrep'])
   call denite#custom#var('grep', 'recursive_opts', [])
   call denite#custom#var('grep', 'pattern_opt', [])
   call denite#custom#var('grep', 'separator', ['--'])
   call denite#custom#var('grep', 'final_opts', [])
 endif
 call denite#custom#source('grep', 'converters', ['converter/abbr_word'])
