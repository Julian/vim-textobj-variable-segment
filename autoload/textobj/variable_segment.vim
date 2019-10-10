function! s:select(object_type)

    let left_boundary = ['_\+\i', '\<', '\l\u', '\u\u\ze\l', '\a\d', '\d\a']

    if (a:object_type == 'a')
        let right_boundary = ['_', '\l\u', '\u\u\l', '\a\d', '\d\a', '\i\>']
    endif

    if (a:object_type == 'i')
        let right_boundary = ['\i_', '\l\u', '\u\u\l', '\a\d', '\d\a', '\i\>']
    endif

    call search(join(left_boundary, '\|'), 'bce')
    let start_position = getpos('.')

    call search('\>', 'c')
    let word_end = getpos('.')
    call setpos('.', start_position)

    call search(join(right_boundary, '\|'), 'c')
    for _ in range(v:count1 - 1)
        if getpos('.') != word_end
            call search(join(right_boundary, '\|'))
        endif
    endfor
    let end_position = getpos('.')

    return ['v', start_position, end_position]
endfunction

function! s:select_a()
    let [type, start_position, end_position] = s:select('a')
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
    return s:select('i')
endfunction

function! textobj#variable_segment#select_i() abort
  return s:select_i()
endfunction

function! textobj#variable_segment#select_a() abort
  return s:select_a()
endfunction
