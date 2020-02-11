set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:\│

set list
set listchars=nbsp:☠,tab:│\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81

" Colors
set notermguicolors t_Co=16
set background=dark
colorscheme wal

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
    autocmd ColorScheme * hi StatusLine      ctermfg=8  ctermbg=3
    autocmd ColorScheme * hi StatusLineNC    ctermfg=4  ctermbg=2
    autocmd ColorScheme * hi VertSplit       ctermfg=4  ctermbg=2 cterm=bold
endif

" vim:set fdl=0 fdm=marker:
