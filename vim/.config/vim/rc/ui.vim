set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:│
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81

" Colors
colorscheme monochrome

" nofrils options
let g:nofrils_strbackgrounds=1
let g:nofrils_heavylinenumbers=0
let g:nofrils_heavycomments=1

" visual bell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" vim:set fdl=0 fdm=marker:
