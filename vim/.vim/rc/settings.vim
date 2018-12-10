""""""""""""""""""""""""""""""""""""""""
" Settings                             "
""""""""""""""""""""""""""""""""""""""""
syntax on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

set bomb
set binary

" Swap files, history & persistence {{{
    " No backup (that's what git is for!) and swapfiles are annoying
    set nobackup
    set nowritebackup
    set noswapfile
    if has('persistent_undo')
        set undodir=~/.cache/vim/undo
        set undolevels=500
        set undoreload=500
    endif
    set history=5000

    " preserve buffer state (cursor location, folds, etc.)
    set viewdir=~/.cache/vim/views
    set viewoptions=cursor,folds,unix,slash
    augroup vimrc-persistence
        au!
        au BufWinLeave * if expand("%") != "" | silent! mkview | endif
        au BufWinEnter * if expand("%") != "" | silent! loadview | endif
    augroup END
" }}}

set autoread                 " Auto-update a file that's been edited externally
set backspace=indent,eol,start
set hidden                   " Allow buffer switching without saving
set lazyredraw               " Don't update screen while running macros
set ttyfast
set noeol
set nospell                  " No spell check, please
set nrformats-=octal
set shortmess+=filmnrxoOtTs
set visualbell               " No sounds!
set modeline

set iskeyword-=.             " Regard . as a word boundary
set iskeyword-=_             " Regard _ as a word boundary
set iskeyword-=#             " Regard # as a word boundary

" Show buffer name in tmux window name
set titlestring=%f%m
set title

" Disable matchit highlighting, I find it distracting
let loaded_matchparen = 1

" Switch to current file directory
autocmd BufEnter * silent! lcd %:p:h

" Automatically close the popup menu / preview window
au InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Do syntax highlighting from the start
au BufEnter * :syntax sync fromstart

" Enable clipboard
if has('unnamedplus')
    set clipboard=unnamed,unnamedplus
else
    set clipboard=unnamed
endif

augroup vimrc-remember-cursor-position
    au!
    au BufWinEnter * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" Movement & search {{{
    set nostartofline
    set sidescrolloff=5
    set incsearch            " find as you type
    set hlsearch             " Highlight search terms
    set ignorecase           " case insensitive search
    set smartcase            " case sensitive when uc present
    set gdefault             " global flag for substitute by default

    let g:ackprg='rg --vimgrep'
    set grepprg=rg\ --vimgrep
" }}}

" Text formatting {{{
    set autoindent
    set expandtab
    set shiftround
    set shiftwidth=4 tabstop=4 softtabstop=4
    set nowrap
    " Backspace and cursor keys to wrap
    set whichwrap=b,s,h,l,<,>,[,]
    " see :h fo-table
    set formatoptions=qrn1lr

    function! <SID>StripTrailingWhitespaces()
        if &ft =~ 'vim'
            return
        endif
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        call cursor(l, c)
    endfunction
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
" }}}

" Folding {{{
    set foldlevel=1
    " Cleaner, more readable fold headers
    set foldtext=MyFoldText()
    function! MyFoldText()
        let line = getline(v:foldstart)
        " Lines that have been folded
        let nl = v:foldend - v:foldstart + 1
        let indent = repeat(' ', indent(v:foldstart))
        let endcol = &colorcolumn ? &colorcolumn : &textwidth
        let startcol = &columns < endcol ? &columns-4 : endcol
        return indent . substitute(line,"^ *","",1)
    endfunction
" }}}

