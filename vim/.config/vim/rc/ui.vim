set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:│
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81

" Colors
colorscheme nofrils-dark

" Status Line
set laststatus=2                                " Enable the statusline
set statusline=%!ActiveStatus()                 " Style it

function! ActiveStatus() abort                  " When in the active window
    let statusline=""                           " Initialize it
    let statusline.="%3*%m"                     " Modified flag
    let statusline.="%6*%{expand('%:p:h')}/"    " Full-path to current buffer
    let statusline.="%4*%t"                     " File name
    let statusline.="%5*%{GitBranch()}"         " Show Git branch, if applicable
    let statusline.="%="                        " Switch to right-side
    let statusline.="%4*%y\ "                   " Filetype
    let statusline.="%3*"                       " Color change (see :hi)
    let statusline.="\|%4l\:%2c\|"              " Line and column
    let statusline.="%2*%{&spell?'[SPELL]':''}" " Spell flag
    let statusline.="%1*%r%0*"                  " Read-only flag
    return statusline
endfunction

function! PassiveStatus() abort                 " When in a non-active window
    let statusline=""                           " Initialize it
    let statusline.="%6*%m"                     " Modified flag
    let statusline.="%{expand('%:p:h')}/"       " Full-path to current buffer
    let statusline.="%t"                        " File name
    let statusline.="%{GitBranch()}"            " Show Git branch, if applicable
    let statusline.="%="                        " Switch to right-side
    let statusline.="%y\ "                      " Filetype
    let statusline.="\|%4l\:%2c\|"              " Line and column
    let statusline.="%{&spell?'[SPELL]':''}"    " Spell flag
    let statusline.="%r%0*"                     " Read-only flag
    return statusline
endfunction

augroup user_statusline                         " Change based on active window 
    autocmd!
    autocmd WinEnter * setlocal statusline=%!ActiveStatus()
    autocmd WinLeave * setlocal statusline=%!PassiveStatus()
augroup END

function! GitBranch() abort
    let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null
                \ | tr -d '\n'")
    return strlen(l:branchname) > 0 ? '#'.l:branchname : ''
endfunction

" vim:set fdl=0 fdm=marker:
