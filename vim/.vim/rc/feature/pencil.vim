Plug 'reedes/vim-pencil'

augroup pencil
    autocmd!
    autocmd FileType markdown,mkd,md call pencil#init({'wrap': 'soft'})
    autocmd FileType text            call pencil#init({'wrap': 'hard'})
augroup END

let g:pencil#textwidth     = 74
let g:pencil#cursorwrap    = 1
let g:pencil#conceallevel  = 3    " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)