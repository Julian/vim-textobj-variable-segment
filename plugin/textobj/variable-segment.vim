" textobj-variable-segment: a text object for segments of variable names
" Author: Julian Berman
" Version: 0.2.0

if exists('g:loaded_textobj_variable_segment')
    finish
endif

call textobj#user#plugin('variable', {
    \ '-': {
    \     '*sfile*': expand('<sfile>:p'),
    \     'select-a': 'av',  '*select-a-function*': 's:select_a',
    \     'select-i': 'iv',  '*select-i-function*': 's:select_i',
    \ }})

function! s:select(object_type)
    let variable = expand('<cword>')

    let left_boundary = join(['_\i', '\l\u', '\<'], '\|')
    call search(left_boundary, 'bce')
    let start_position = getpos('.')

    if a:object_type == 'a'
        let right_boundary = join(['_', '\l\u', '\i\>'], '\|')
    else
        let right_boundary = join(['\i_', '\l\u', '\i\>'], '\|')
    endif
    call search(right_boundary . '\|\i\>', 'c')
    let end_position = getpos('.')

    call search('\i\>', 'c')
    if a:object_type == 'a' &&
     \ end_position == getpos('.') &&
     \ getline(start_position[1])[start_position[2] - 2] =~# '_'
        let start_position[2] -= 1
    endif

    let was_small_camel = match(variable, '^_*\l.*\u') != -1
    if a:object_type == 'a' && was_small_camel
        let [_, line_number, column, _] = start_position

        call search('\<', 'bc')
        let [_, _, word_start, _] = getpos('.')

        if column - 2 <= word_start || getline(line_number)[:column - 2] =~# '^_*$'
            call setpos('.', end_position)
            normal! l~
        endif
    endif

    return ['v', start_position, end_position]
endfunction

function! s:select_a()
    return s:select('a')
endfunction

function! s:select_i()
    return s:select('i')
endfunction

let g:loaded_textobj_variable_segment = 1
