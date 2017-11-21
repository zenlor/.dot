set background=dark
set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:│
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81
" set cursorline     " Line highlight

" No background in terminal
if has("autocmd") && !has("gui_running")
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    " autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
end

" Statusline {{{
    set ruler  " Show line/col no in statusline
    let g:currentmode={
                \ 'n'  : 'N ',
                \ 'no' : 'N·Operator Pending ',
                \ 'v'  : 'V ',
                \ 'V'  : 'V·Line ',
                \ '^V' : 'V·Block ',
                \ 's'  : 'Select ',
                \ 'S'  : 'S·Line ',
                \ '^S' : 'S·Block ',
                \ 'i'  : 'I ',
                \ 'R'  : 'R ',
                \ 'Rv' : 'V·Replace ',
                \ 'c'  : 'Command ',
                \ 'cv' : 'Vim Ex ',
                \ 'ce' : 'Ex ',
                \ 'r'  : 'Prompt ',
                \ 'rm' : 'More ',
                \ 'r?' : 'Confirm ',
                \ '!'  : 'Shell ',
                \ 't'  : 'Terminal ',
                \}

    function! ReadOnly()
        if &readonly || !&modifiable
            return ''
        else
            return ''
    endfunction

    function! GitInfo()
        let git = fugitive#head()
        if git != ''
            return ' '.fugitive#head()
        else
            return ''
        endif
    endfunction

    function! AleInfo()
        let l:counts = ale#statusline#Count(bufnr(''))
        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors

        return l:counts.total == 0 ? '' : printf(
                    \ '%dW %dE',
                    \ all_non_errors,
                    \ all_errors
                    \)
    endfunction

    function! SetUserColors()
        " Black on Green
        hi User1 guifg=#000000 guibg=#7dcc7d gui=NONE ctermfg=0 ctermbg=2 cterm=NONE
        " White on Red
        hi User2 guifg=#ffffff guibg=#ff0000 gui=bold ctermfg=15 ctermbg=9 cterm=bold
        " Yellow on Blue
        hi User3 guifg=#ffff00 guibg=#5b7fbb gui=bold ctermfg=190 ctermbg=67 cterm=bold
        " White on Purple
        hi User4 guifg=#ffffff guibg=#810085 gui=NONE ctermfg=15 ctermbg=53 cterm=NONE
        " White on Black
        hi User5 guifg=#ffffff guibg=#000000 ctermfg=15 ctermbg=0
        " White on Pink
        hi User6 guifg=#ffffff guibg=#ff00ff ctermfg=15 ctermbg=5
        " Pink on Black
        hi User7 guifg=#ff00ff guibg=#000000 gui=bold ctermfg=207 ctermbg=0 cterm=bold
        " Black on Cyan
        hi User8 guifg=#000000 guibg=#00ffff gui=bold ctermfg=0 ctermbg=51 cterm=bold
    endfunction

    "au ColorScheme * call SetUserColors()

    set laststatus=2
    set statusline=
    set statusline+=%0*\ %{toupper(g:currentmode[mode()])}      " Current mode
    set statusline+=%1*\ [%n]                                   " buffernr
    set statusline+=%9*\ %{GitInfo()}                           " Git Branch name
    set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\           " File+path
    set statusline+=%#warningmsg#
    set statusline+=%*
    set statusline+=%9*\ %=                                     " Space
    set statusline+=%8*\ %y\                                    " FileType
    set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\    " Encoding & Fileformat
    set statusline+=%0*\ %3p%%\ %l:%2c\                        " Rownumber/total (%)
    set statusline+=%2*\ %{AleInfo()}
" }}}

colorscheme molokai
