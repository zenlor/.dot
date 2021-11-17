set nocompatible

filetype off

call plug#begin('~/.cache/vim/bundle')

" Essentials {{{
    Plug 'editorconfig/editorconfig-vim'
" }}}

" Vim functionality fixes/enhancements {{{
    Plug 'tpope/vim-repeat'         " better repeat compatibility ('.')
    Plug 'tpope/vim-commentary'     " comment things
    Plug 'vim-scripts/vis'          " improved visual commands
    Plug 'justinmk/vim-sneak'       " 2-character search motions
    Plug 'tpope/vim-surround'       " manipulation of surrounding delimiters
    Plug 'tpope/vim-vinegar'        " vinegar dressing for netrw
    Plug 'tpope/vim-fugitive'       " git
    Plug 'tpope/vim-sleuth'         " find the right setup
    Plug 'tpope/vim-eunuch'         " use the tools

    Plug 'jiangmiao/auto-pairs'

    " fzf
    Plug 'junegunn/fzf', { 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " project root finder
    Plug 'mattn/vim-findroot'

    " align easily
    Plug 'junegunn/vim-easy-align'

    if has('nvim')
        " Aniseed to use fennel as lua plugin
        Plug 'Olical/aniseed', { 'tag': 'v3.11.0' }

        " repl
        Plug 'Olical/conjure', {'tag': 'v4.8.0'}
    endif
" }}}

" Vim visuals {{{
    " rainbows
    Plug 'junegunn/rainbow_parentheses.vim'
    " match parentheses
    Plug 'andymass/vim-matchup'
    " theme
    Plug 'xero/sourcerer.vim'
" }}}

" lang {{{

    " LSP client
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    " Clojure
    Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }
    Plug 'venantius/vim-cljfmt',            { 'for': 'clojure' }

    " *lisp
    Plug 'eraserhd/parinfer-rust',          { 'do': 'cargo build --release',
                                            \ 'for': ['clojure','scheme','lisp', 'janet']}

    " Javascript
    Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }

    " Go
    Plug 'fatih/vim-go',                    { 'for': 'go', 'do': ':GoInstallBinaries' }

    " Data
    Plug 'honza/dockerfile.vim'

    " Rust
    Plug 'rust-lang/rust.vim',              { 'for': 'rust' }

    " Lua
    Plug 'wolfgangmehner/lua-support',      { 'for': 'lua' }

    " Fennel
    Plug 'bakpakin/fennel.vim',             { 'for': 'fennel' }

    " Janet
    Plug 'bakpakin/janet.vim',              { 'for': 'janet' }

    " C
    Plug 'WolfgangMehner/c-support',        { 'for': 'c' }

    " Terraform
    Plug 'hashivim/vim-terraform',          { 'for': 'terraform' }

    " Nix
    Plug 'LnL7/vim-nix',                    { 'for': 'nix' }

    " Groovy ... for jenkins
    Plug 'jovandeginste/vim-groovy',        { 'for': 'groovy' }

    " Python
    Plug 'hynek/vim-python-pep8-indent',    { 'for': 'python' }

    " Markdown
    Plug 'tpope/vim-markdown'
" }}}

" git {{{
  Plug 'tpope/vim-fugitive'
" }}}

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""
" Settings                             "
""""""""""""""""""""""""""""""""""""""""
syntax on

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

function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

let g:intendLine_char = '⦙'
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

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

" UI {{{

" tmux support
if &term =~ "screen."
   let &t_ti.="\eP\e[1 q\e\\"
   let &t_SI.="\eP\e[5 q\e\\"
   let &t_EI.="\eP\e[1 q\e\\"
   let &t_te.="\eP\e[0 q\e\\"
else
   let &t_ti.="\<Esc>[1 q"
   let &t_SI.="\<Esc>[5 q"
   let &t_EI.="\<Esc>[1 q"
   let &t_te.="\<Esc>[0 q"
endif

set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:\│

set list
set listchars=nbsp:☠,tab:│\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81

" Colors
set notermguicolors t_Co=16
set background=dark
"colorscheme 256_noir

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

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" }}}

"""
""" bindings {{{
"""
" enable mouse integration
set mouse=a

" map leader key to <space>
let mapleader = ' '
" map local leader key to <comma>
let maplocalleader = ','

" Trigger to preserve indentation on pastes
set pastetoggle=<F12>
" Easier than escape. Pinnacle of laziness.
inoremap jk <ESC>
inoremap Jk <ESC>
inoremap JK <ESC>
inoremap jK <ESC>
" Turn off search highlighting
noremap <silent> <leader>? :nohlsearch<CR>

nnoremap <leader>h :<C-u>h

nnoremap <ESC><ESC> :nohl<CR>

" Navigation {{{
    " Normalize all the navigation keys to move by row/col despite any wrapped text
    noremap j gj
    noremap k gk
    " % matchit shortcut, but only in normal mode!
    nmap <Tab> %
    " Easier fold toggle
    nnoremap <Space> 5j
    vnoremap <Space> 5j
    nnoremap <Backspace> 5k
    vnoremap <Backspace> 5k

    " Make motions sensitive to wrapped lines
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
        let vis_sel=""
        if a:0
            let vis_sel="gv"
        endif
        if &wrap
            execute "normal!" vis_sel . "g" . a:key
        else
            execute "normal!" vis_sel . a:key
        endif
    endfunction

    " Map g* keys in Normal, Operator-pending, and Visual+select
    noremap <silent> $ :call WrapRelativeMotion("$")<CR>
    noremap <silent> <End> :call WrapRelativeMotion("$")<CR>
    noremap <silent> 0 :call WrapRelativeMotion("0")<CR>
    noremap <silent> <Home> :call WrapRelativeMotion("0")<CR>
    noremap <silent> ^ :call WrapRelativeMotion("^")<CR>
    " Overwrite the operator pending $/<End> mappings from above
    " to force inclusive motion with :execute normal!
    onoremap <silent> $ v:call WrapRelativeMotion("$")<CR>
    onoremap <silent> <End> v:call WrapRelativeMotion("$")<CR>
    " Overwrite the Visual+select mode mappings from above
    " to ensure the correct vis_sel flag is passed to function
    vnoremap <silent> $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <silent> <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
    vnoremap <silent> 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <silent> <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
    vnoremap <silent> ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
" }}}

" Editing {{{
    nnoremap <C-b> <C-^>
    " Insert-mode navigation
    " Go to end of line
    inoremap <C-e> <Esc>A
    " Go to start of line
    inoremap <C-a> <Esc>I

    " Make Y act consistant with C and D
    nnoremap Y y$

    " Don't leave visual mode after indenting
    vnoremap < <gv
    vnoremap > >gv

    " Textmate-like CMD+Enter (O in insert mode)
    inoremap <S-CR> <C-O>o
    inoremap <C-S-CR> <C-O>O

    " Enabling repeat in visual mode
    vmap . :normal .<CR>
" }}}

" Buffers {{{
    " Next/prev buffer
    nnoremap ]b :<C-u>bnext<CR>
    nnoremap [b :<C-u>bprevious<CR>
" }}}

" Command {{{
    " Annoying command mistakes <https://github.com/spf13/spf13-vim>
    com! -bang -nargs=* -complete=file E e<bang> <args>
    com! -bang -nargs=* -complete=file W w<bang> <args>
    com! -bang -nargs=* -complete=file Wq wq<bang> <args>
    com! -bang -nargs=* -complete=file WQ wq<bang> <args>
    com! -bang Wa wa<bang>
    com! -bang WA wa<bang>
    com! -bang Q q<bang>
    com! -bang QA qa<bang>
    com! -bang Qa qa<bang>
    " Forget to sudo?
    com! WW w !sudo tree % >/dev/null

    " Shortcuts
    cnoremap ;/ <C-R>=expand('%:p:h').'/'<CR>
    cnoremap ;; <C-R>=expand("%:t")<CR>
    cnoremap ;. <C-R>=expand("%:p:r")<CR>

    " Mimic shortcuts in the terminal
    cnoremap <C-a> <Home>
    cnoremap <C-e> <End>
" }}}

" External Tools {{{
    " Send cwd to tmux
    nnoremap <leader>t. :<C-u>call VimuxRunCommand("cd <C-r>=expand("%:p:h")<CR>")<CR>
    nnoremap <leader>t/ :<C-u>call VimuxRunCommand("cd <C-r>=getcwd()<CR>")<CR>
    nnoremap <leader>ts :<C-u>call VimuxRunCommand("tmux split-window")<CR>
    nnoremap <leader>tv :<C-u>call VimuxRunCommand("tmux split-window -h")<CR>
    nnoremap <leader>tc :<C-u>call VimuxRunCommand("tmux new-window")<CR>

    com! -nargs=* T call VimuxRunCommand(<q-args>)
" }}}

" Plugins {{{
    " bufkill
    nnoremap zx :bdelete<CR>

    " Tabularize
    nmap <leader>= :Tabularize /
    vmap <leader>= :Tabularize /

    " Sneak
    "replace 'f' with 1-char Sneak
    nmap f <Plug>Sneak_f
    nmap F <Plug>Sneak_F
    xmap f <Plug>Sneak_f
    xmap F <Plug>Sneak_F
    omap f <Plug>Sneak_f
    omap F <Plug>Sneak_F
    "replace 't' with 1-char Sneak
    nmap t <Plug>Sneak_t
    nmap T <Plug>Sneak_T
    xmap t <Plug>Sneak_t
    xmap T <Plug>Sneak_T
    omap t <Plug>Sneak_t
    omap T <Plug>Sneak_T

    " vim-switch
    nnoremap ! :Switch<CR>

    " vim-sneak
    map f <Plug>Sneak_f
    map F <Plug>Sneak_F
    map t <Plug>Sneak_t
    map T <Plug>Sneak_T
" }}}

" Completion {{{
    inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
    imap <C-@> <C-Space>
" }}}

" Windows {{{
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l
" }}}

nnoremap <silent> <Leader>bs :w<CR>
"""}}}

"""
""" EasyAlign
""" {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
""" }}}

"""
""" Environment
""" {{{
let g:python3_host_prog = '/usr/bin/python3'
"""}}}

"""
""" FZF
""" {{{
if has("unix")
  let s:uname = system("uname")
  if s:uname =~ "darwin"
      set rtp+=/usr/local/opt/fzf
  endif
endif

nnoremap <silent> <leader><space> :Files<CR>
nnoremap <silent> <leader>a :Buffers<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :History<CR>
nnoremap <silent> <leader>/ :execute 'Rg ' . input('Rg/')<CR>
nnoremap <silent> <leader>. :RgIn

nnoremap <silent> K :call SearchWordWithRg()<CR>
vnoremap <silent> K :call SearchVisualSelectionWithRg()<CR>
nnoremap <silent> <leader>gl :Commits<CR>
nnoremap <silent> <leader>ga :BCommits<CR>
nnoremap <silent> <leader>ft :Filetypes<CR>
nnoremap <silent> <leader>bb :Buffers<CR>

imap <C-x><C-f> <plug>(fzf-complete-file-rg)
imap <C-x><C-l> <plug>(fzf-complete-line)

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>

function! SearchWordWithRg()
  execute 'Rg' expand('<cword>')
endfunction

function! SearchVisualSelectionWithRg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Rg' selection
endfunction

function! SearchWithRgInDirectory(...)
  call fzf#vim#rg(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir RgIn call SearchWithRgInDirectory(<f-args>)

augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END


let g:terraform_align=1
let g:terraform_fmt_on_save=1
autocmd BufRead,BufNewFile *.hcl set filetype=terraform
""" }}}

"""
""" {{{ Git
"""
" git-gutter
let g:gitgutter_sign_added              = '+'
let g:gitgutter_sign_modified           = '~'
let g:gitgutter_sign_removed            = '−'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed   = '≃'
""" }}}

"""
""" {{{ Gui
"""
if has('gui_running')
    " Say neigh to UI cruft!
    set go-=T
    set go-=l
    set go-=L
    set go-=r
    set go-=R
    " No GUI tabs!
    set go-=e
    " Don't show dialogues, use text prompts
    set go+=c

    " Sets File>Open to start in current file's path
    set browsedir=buffer

    " MacOS
    if has('gui_macvim')

        " j doesn't seem to work from terminal
        set formatoptions+=j

        " set guifont=Ubuntu\ Mono:h14
        " set guifont=Monaco:h12
        set guifont=Inconsolata:h16

        " Replace some CMD shortcuts
        macmenu &File.Open\.\.\. key=<nop>
        macmenu &Tools.Make key=<nop>

        " Switching buffers
        nmap <D-]> ]b
        nmap <D-[> [b

        " Textmate-like CMD+Enter
        inoremap <D-CR> <C-O>o
        inoremap <S-D-CR> <C-O>O

        " Fast scrolling
        map <D-j> 5j
        map <D-k> 5k
        imap <D-j> <C-o>5j
        imap <D-k> <C-o>5k

        " Commenting using CMD+/"
        nmap <D-/> gcc
        vmap <D-/> gc

        map <D-r> <leader>r
        " Replace :make
        map <D-b> :Dispatch<CR>

        " Shortcuts to outside apps {{{
            " Open in finder
            nnoremap <localleader>f :silent !open "%:p:h"<CR>
            nnoremap <localleader>F :silent !open .<CR>

            " Open in terminal
            nnoremap <localleader>t :silent !open -a iTerm "%:p:h"<CR>
            nnoremap <localleader>T :silent !open -a iTerm .<CR>

            " Send to transmit
            nnoremap <localleader>u :silent !open -a Transmit "%"<CR>

            " Send to launchbar (project and file, respectively)
            nnoremap <silent> <localleader>[ :call LaunchBarSelect(expand("%:p:h"))<CR>
            nnoremap <silent> <localleader>] :call LaunchBarSelect(expand("%:p"))<CR>

            func LaunchBarSelect(arg)
                silent! let l:arg = substitute(a:arg, '[^A-Za-z0-9_.~-/]','\="%".printf("%02X",char2nr(submatch(0)))','g')
                if l:arg ==# ""
                    let l:arg = expand("%:p:h")
                endif
                exec 'silent !open "x-launchbar:select?file=' . l:arg . '"'
            endfunc
        " }}}

    " For unix/other
    else

        inoremap <C-v> <C-r>*
        cnoremap <C-v> <C-r>*

        set go-=m
        set novisualbell

        " For gvim
        if has('nvim')
            Guifont Fira Mono:h13
        endif

        " Commenting using Ctrl+/
        map <C-/> gcc

        " Textmate-like CMD+Enter
        inoremap <C-CR> <C-O>o
        inoremap <S-C-CR> <C-O>O

    endif

    if has('win32')
        set guifont=Consolas:h12   " Win32.
    elseif has('gui_macvim')
        set guifont=Fira\ Mono:h14     " OSX.
    else
        set guifont=Fira\ Mono\ 13  " Linux.
    endif
endif

if exists('g:GuiFont')
    GuiFont! Iosevka Term:h13
endif
"}}}

" Language configuration

" Clojure & Lisp & Scheme {{{
    function! s:lisp_maps()
        nnoremap <buffer> <leader>a[ vi[<c-v>$:EasyAlign\ g/^\S/<cr>gv=
        nnoremap <buffer> <leader>a{ vi{<c-v>$:EasyAlign\ g/^\S/<cr>gv=
        nnoremap <buffer> <leader>a( vi(<c-v>$:EasyAlign\ g/^\S/<cr>gv=
        nnoremap <buffer> <leader>rq :silent update<bar>Require<cr>
        nnoremap <buffer> <leader>rQ :silent update<bar>Require!<cr>
        nnoremap <buffer> <leader>rt :silent update<bar>RunTests<cr>
        nmap     <buffer> <leader>*  cqp<c-r><c-w><cr>
        nmap     <buffer> <c-]>      <Plug>FireplaceDjumpzz
        imap     <buffer> <c-j><c-n> <c-o>(<right>.<space><left><tab>
    endfunction

    function! s:figwheel()
        call system('tmux send-keys -t right C-u "(figwheel-sidecar.repl-api/start-figwheel!)" Enter')
        call input('Press enter when ready.')
        redraw!
        Piggieback (figwheel-sidecar.repl-api/repl-env)
    endfunction

    augroup vimrc
        autocmd FileType lisp,clojure,scheme RainbowParentheses
        autocmd FileType lisp,clojure,scheme call <sid>lisp_maps()

        " Clojure
        autocmd FileType clojure xnoremap <buffer> <silent> <cr>         "cy:Eval <c-r>c<cr>
        autocmd FileType clojure xnoremap <buffer> <silent> <leader><cr> "cy:Eval (require 'clojure.pprint)(clojure.pprint/pprint <c-r>c)<cr>
        autocmd FileType clojure nmap     <buffer> <Enter>      cpp

        " Figwheel
        autocmd BufReadPost *.cljs command! -buffer Figwheel call s:figwheel()
    augroup END

    let g:clojure_maxlines = 60

    set lispwords+=match
    let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let']

    " let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

    " vim-cljfmt
    let g:clj_fmt_autosave = 0
    autocmd vimrc BufWritePre *.clj call cljfmt#AutoFormat()
    autocmd vimrc BufWritePre *.cljc call cljfmt#AutoFormat()

" }}}


""" Omnicomplete + wild settings {{{
    set tags=./tags,./../tags,./../../tags,./../../../tags,tags

    set complete-=i
    set completeopt=menu
    set wildmenu                    " Show menu instead of auto-complete
    set wildmode=list:longest,full  " command <Tab> completion: list
                                    " matches -> longest common -> then
                                    " all.
    set wildignore+=*.swp,*.log,.sass-cache,.codekit-cache,config.codekit
    set wildignore+=*.class,*.o,*.pyc,*.obj,*DS_Store*
""" }}}

""" Prose {{{
let g:markdown_fenced_languages = ['css', 'terraform', 'tf=terraform', 'javascript', 'js=javascript', 'shell=sh', 'sass', 'xml']

if has("autocmd")
  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text,markdown setlocal textwidth=78
endif " has("autocmd")
"""}}}

" vim:set fdl=0 fdm=marker:
