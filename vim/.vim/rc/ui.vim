set enc=utf-8
set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:\│

set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81

" Colors
set t_Co=256
colorscheme default

" visual bell
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" statusline
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P
set laststatus=2

" statusline, splits colors
if has('autocmd')
    autocmd ColorScheme * hi StatusLine      ctermfg=238  ctermbg=253
    autocmd ColorScheme * hi StatusLineNC    ctermfg=244  ctermbg=232
    autocmd ColorScheme * hi VertSplit       ctermfg=244  ctermbg=232 cterm=bold
endif

" vim:set fdl=0 fdm=marker:
