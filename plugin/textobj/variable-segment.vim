" textobj-variable-segment: a text object for segments of variable names
" Author: Julian Berman
" Version: 0.3.0

if exists('g:loaded_textobj_variable_segment')
    finish
endif


call textobj#user#plugin('variable', {
    \ '-': {
    \     '*sfile*': expand('<sfile>:p'),
    \     'select-a': 'av',  '*select-a-function*': 's:select_a',
    \     'select-i': 'iv',  '*select-i-function*': 's:select_i',
    \ }})


function! s:select(object_type, right_boundary)
    let left_boundaries = ['_\i', '\l\u', '\u\u\ze\l', '\a\d', '\d\a', '\<']
    call search(join(left_boundaries, '\|'), 'bce')
    let start_position = getpos('.')

    call search('\>', 'c')
    let word_end = getpos('.')
    call setpos('.', start_position)

    call search(a:right_boundary, 'c')
    for _ in range(v:count1 - 1)
        if getpos('.') != word_end
            call search(a:right_boundary)
        endif
    endfor
    let end_position = getpos('.')

    return ['v', start_position, end_position]
endfunction


function! s:select_a()
    let right_boundaries = ['_', '\l\u', '\u\u\l', '\a\d', '\d\a', '\i\>']
    let right_boundary = join(right_boundaries, '\|')
    let [type, start_position, end_position] = s:select('a', right_boundary)
    let [_, start_line, start_column, _] = start_position

    call search('\i\>', 'c')
    if end_position == getpos('.') &&
     \ getline(start_line)[start_column - 2] =~# '_'
        let start_position[2] -= 1
    endif

    let was_small_camel = match(expand('<cword>'), '^_*\l.*\u') != -1
    if was_small_camel
        call search('\<', 'bc')
        let [_, _, word_start, _] = getpos('.')

        if start_column - 2 <= word_start ||
         \ getline(start_line)[:start_column - 2] =~# '^_*$'
            call setpos('.', end_position)
            normal! l~
        endif
    endif

    return [type, start_position, end_position]
endfunction


function! s:select_i()
    let right_boundaries = ['\i_', '\l\u', '\u\u\l', '\a\d', '\d\a', '\i\>']
    return s:select('i', join(right_boundaries, '\|'))
endfunction


let g:loaded_textobj_variable_segment = 1
