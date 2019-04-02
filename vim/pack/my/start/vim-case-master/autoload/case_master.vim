scriptencoding utf-8

if !exists('g:loaded_case_master')
    finish
endif
let g:loaded_case_master = 1

let s:case_snake = 1
let s:case_kebab = 2
let s:case_camel = 3
let s:case_pascal = 4

let s:case_first = s:case_snake
let s:case_last = s:case_pascal

let s:case_names = {}
let s:case_names[s:case_snake] = 'snake_case'
let s:case_names[s:case_kebab] = 'kebab-case'
let s:case_names[s:case_camel] = 'camelCase'
let s:case_names[s:case_pascal] = 'PascalCase'

function! case_master#log(message) abort
  echom '[CaseMaster] ' . a:message
endfunction

function! case_master#detect_case(chunk) abort
  if !empty(matchstr(a:chunk, '-'))
    return s:case_kebab
  endif
  if !empty(matchstr(a:chunk, '_'))
    return s:case_snake
  endif
  return a:chunk[0] =~# '\u' ?  s:case_pascal : s:case_camel
endfunction

function! case_master#split(chunk) abort
  let l:a = split(a:chunk, '\u\@=')
  let l:b = []
  for l:w in l:a
    let l:b += split(l:w, '_')
  endfor
  let l:c = []
  for l:w in l:b
    let l:c += split(l:w, '-')
  endfor
  return l:c
endfunction

function! case_master#get_current_chunk_pos() abort
  let l:y = col('.')
  let l:line = getline('.')
  let splitted = split(l:line, ' ', v:true)
  if l:line[l:y - 1] ==# ' '
    return [' ', l:y - 1, l:y]
  endif
  let l:end = 1
  for l:w in splitted
    let l:start = l:end - 1
    let l:end += len(l:w) + 1
    if l:end > l:y
      break
    endif
  endfor
  let l:end -= 2
  return [l:start, l:end]
endfunction

function! case_master#to_snake(chunk) abort
  return tolower(join(case_master#split(a:chunk), '_'))
endfunction

function! case_master#to_kebab(chunk) abort
  return tolower(join(case_master#split(a:chunk), '-'))
endfunction

function! case_master#to_capival(chunk, camel) abort
  let l:words = case_master#split(a:chunk)
  let l:first = v:true
  let l:ret = ''
  for l:word in l:words
    if a:camel && l:first
      let l:ret .= tolower(l:word)
    else
      let l:ret .= toupper(l:word[0]) . tolower(l:word[1:])
    endif
    let l:first = v:false
  endfor
  return l:ret
endfunction

function! case_master#to_camel(chunk) abort
  return case_master#to_capival(a:chunk, v:true)
endfunction

function! case_master#to_pascal(chunk) abort
  return case_master#to_capival(a:chunk, v:false)
endfunction

function! case_master#to_case(chunk, case) abort
  if a:case == s:case_snake
    return case_master#to_snake(a:chunk)
  endif
  if a:case == s:case_kebab
    return case_master#to_kebab(a:chunk)
  endif
  if a:case == s:case_camel
    return case_master#to_camel(a:chunk)
  endif
  return case_master#to_pascal(a:chunk)
endfunction

function! case_master#to_next_case(chunk) abort
  let l:case = case_master#detect_case(a:chunk)
  let l:old_case = l:case
  let l:case += 1
  if l:case > s:case_last
    let l:case = s:case_first
  endif
  call case_master#log(s:case_names[l:old_case] . ' -> ' . s:case_names[l:case])
  return case_master#to_case(a:chunk, l:case)
endfunction

function! case_master#rotate_case() abort
  let l:pos = case_master#get_current_chunk_pos()
  let l:line = getline('.')
  let l:chunk = strpart(l:line, l:pos[0], l:pos[1] - l:pos[0])
  if l:chunk ==# ' '
    call case_master#log('blank')
    return
  endif
  let l:replacer = case_master#to_next_case(l:chunk)
  let l:pre = strpart(l:line, 0, l:pos[0])
  let l:post = strpart(l:line, l:pos[1], len(l:line))
  call setline('.', l:pre . l:replacer . l:post)
endfunction
