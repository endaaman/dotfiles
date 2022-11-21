
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


nnoremap <Space>J :<C-u>Denite coc-diagnostic -default-action=jump<CR>
