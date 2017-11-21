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

    set laststatus=2
    set statusline=
    set statusline+=%0*\ %{toupper(g:currentmode[mode()])}      " Current mode
    set statusline+=%8*\ [%n]                                   " buffernr
    set statusline+=%8*\ %{GitInfo()}                           " Git Branch name
    set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ %w\           " File+path
    set statusline+=%#warningmsg#
    set statusline+=%*
    set statusline+=%9*\ %=                                     " Space
    set statusline+=%8*\ %y\                                    " FileType
    set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\[%{&ff}]\    " Encoding & Fileformat
    set statusline+=%0*\ %3p%%\ \ %l:\ %3c\                    " Rownumber/total (%)

    hi User1 ctermfg=007
    hi User2 ctermfg=008
    hi User3 ctermfg=008
    hi User4 ctermfg=008
    hi User5 ctermfg=008
    hi User7 ctermfg=008
    hi User8 ctermfg=008
    hi User9 ctermfg=007
" }}}

colorscheme molokai
