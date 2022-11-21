" let g:vue_pre_processors = ['pug']
" let g:vue_pre_processors = 'detect_on_enter'

let g:vim_markdown_folding_disabled = 1
let g:markdown_enable_spell_checking = 0

autocmd EN BufWritePost *.java UnusedImports
autocmd EN BufEnter *.java UnusedImports

let g:vue_pre_processors = ['pug', 'scss']

let g:vim_json_syntax_conceal = 0

let g:rust_doc#downloaded_rust_doc_dir = $HOME . '/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/share/doc/rust'
let g:rust_doc#define_map_K = 0
" nnoremap <buffer><silent> <Space>K :<C-u>RustDocFuzzy `expand("<cword>")`<CR>
" nnoremap <buffer><silent>K :<C-u>call <SID>search_under_cursor(expand('<cword>'))<CR>
" vnoremap <buffer><silent>K "gy:call <SID>search_under_cursor(getreg('g'))<CR>
"
let g:racer_cmd = Chomp(system('which racer'))
let g:racer_experimental_completer = 1

let g:rustfmt_autosave = 1
let g:rustfmt_command = Chomp(system('which rustfmt'))
autocmd EN FileType rust nmap <Plug>(go-to-def) :<C-u>call racer#GoToDefinition()<CR>
autocmd EN FileType rust nmap <Plug>(go-to-def-tab) :<C-u>split<CR>:call racer#GoToDefinition()<CR><C-w>T
