" Given three positions, return the position closest to the first one.
function! s:closest_position(main, a, b)
    let a_distance = mapnew(a:main, {k,v->abs(v-a:a[k])})
    let b_distance = mapnew(a:main, {k,v->abs(v-a:b[k])})
    if a_distance[1] < b_distance[1]
        return a:a
    endif
    if a_distance[1] > b_distance[1]
        return a:b
    endif
    if a_distance[2] < b_distance[2]
        return a:a
    endif
    if a_distance[2] > b_distance[2]
        return a:b
    endif
    " Distances are the same, return either one
    return a:a
endfunction!

function! s:select(object_type, right_boundary)
    let left_boundaries = ['_\+\k', '\<', '\l\u', '\u\u\ze\l', '\a\d', '\d\a']

    " Gather all possible matches
    let cursor_position = getpos('.')
    let all_positions = []
    for boundary in left_boundaries
        " search() moves the cursor, so we need to reset the cursor's position
        " before each search
        call setpos('.', cursor_position)
        if search(boundary, 'bce') > 0
            call add(all_positions, getpos('.'))
        endif
    endfor

    " Try to find a good match on the same line and on the left of the cursor
    let start_position = v:null
    let potential_matches = filter(copy(all_positions),
        \ {v -> v[1] == cursor_position[1] && v[2] <= cursor_position[2]})
    if len(potential_matches) > 0
        let start_position = reduce(potential_matches,
            \ {a, b -> s:closest_position(cursor_position, a, b)})
    endif

    if type(start_position) == type(v:null)
        " No match found yet, try on the same line but on the right of the
        " cursor
        let potential_matches = filter(copy(all_positions),
            \ {v -> v[1] == cursor_position[1] && v[2] > cursor_position[2]})
        if len(potential_matches) > 0
            let start_position = reduce(potential_matches,
                \ {a, b -> s:closest_position(cursor_position, a, b)})
        endif
    endif

    if type(start_position) == type(v:null)
        " No match found yet, try to find one on lines above the cursor
        let potential_matches = filter(copy(all_positions),
            \ {v -> v[1] < cursor_position[1]})
        if len(potential_matches) > 0
            let start_position = reduce(potential_matches,
                \ {a, b -> s:closest_position(cursor_position, a, b)})
        endif
    endif

    if type(start_position) == type(v:null)
        " No match found yet, try to find one on below after the cursor
        let potential_matches = filter(copy(all_positions),
            \ {v -> v[1] > cursor_position[1]})
        if len(potential_matches) > 0
            let start_position = reduce(potential_matches,
                \ {a, b -> s:closest_position(cursor_position, a, b)})
        endif
    endif

    if type(start_position) == type(v:null)
        " The buffer must not contain any words - fall back to the cursor's
        " position
        let start_position = cursor_position
    endif

    call setpos('.', start_position)
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
    let right_boundaries = ['_', '\l\u', '\u\u\l', '\a\d', '\d\a', '\k\>']
    let right_boundary = join(right_boundaries, '\|')
    let [type, start_position, end_position] = s:select('a', right_boundary)
    let [_, start_line, start_column, _] = start_position

    call search('\k\>', 'c')
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
            let l:tildeop = &tildeop
            set notildeop
            normal! l~
            let &tildeop = l:tildeop
        endif
    endif

    return [type, start_position, end_position]
endfunction

function! s:select_i()
    let right_boundaries = ['\k_', '\l\u', '\u\u\l', '\a\d', '\d\a', '\k\>']
    return s:select('i', join(right_boundaries, '\|'))
endfunction

function! textobj#variable_segment#select_i() abort
  return s:select_i()
endfunction

function! textobj#variable_segment#select_a() abort
  return s:select_a()
endfunction
