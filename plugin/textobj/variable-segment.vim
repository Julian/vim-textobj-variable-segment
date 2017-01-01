" textobj-variable-segment: a text object for segments of variable names
" Author: Julian Berman
" Version: 0.5.0

if exists('g:loaded_textobj_variable_segment')
    finish
endif

call textobj#user#plugin('variable', {
    \ '-': {
    \     'sfile': expand('<sfile>:p'),
    \     'select-a': 'av',  'select-a-function': 'textobj#variable_segment#select_a',
    \     'select-i': 'iv',  'select-i-function': 'textobj#variable_segment#select_i',
    \ }})

let g:loaded_textobj_variable_segment = 1
