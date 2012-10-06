" textobj-space - Text objects for continuity space.
" Version: 0.0.3
" Author : saihoooooooo <saihoooooooo@gmail.com>
" License: So-called MIT/X license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}

if exists('g:loaded_textobj_space')
    finish
endif
let g:loaded_textobj_space = 1
let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('space', {
\     '-': {
\         '*sfile*': expand('<sfile>:p'),
\         'select-a': 'aS', '*select-a-function*': 's:select_a',
\         'select-i': 'iS', '*select-i-function*': 's:select_i',
\     }
\ })

let s:pattern_a = '[[:blank:]　]\+'
let s:pattern_i = ' \+'

function! s:select_a()
    return s:select(s:pattern_a)
endfunction

function! s:select_i()
    return s:select(s:pattern_i)
endfunction

function! s:select(pattern)
    if matchstr(getline('.'), '.', col('.') - 1) !~ a:pattern
        call search(a:pattern)
        if matchstr(getline('.'), '.', col('.') - 1) !~ a:pattern
            return
        endif
    endif

    call search(a:pattern, 'bc')
    let start = getpos('.')
    call search(a:pattern, 'ce')
    let end = getpos('.')
    return ['v', start, end]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
