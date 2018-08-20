filetype off

call plug#begin('~/.cache/vim/bundle')

" Essentials {{{
    Plug 'Shougo/vimproc', { 'do': 'make' }
    Plug 'editorconfig/editorconfig-vim'

    " Git
    Plug 'tpope/vim-fugitive'       " git in vim

    Plug 'sheerun/vim-polyglot'     " support for a variety of languages
" }}}

" Vim functionality fixes/enhancements {{{
    Plug 'tpope/vim-repeat'         " better repeat compatibility ('.')
    Plug 'tpope/vim-commentary'     " comment things
    Plug 'vim-scripts/vis'          " improved visual commands
    Plug 'justinmk/vim-sneak'       " 2-character search motions
    Plug 'tpope/vim-surround'       " manipulation of surrounding delimiters
    Plug 'tpope/vim-vinegar'        " vinegar dressing for netrw

    Plug 'jiangmiao/auto-pairs'

    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } " tagbar

    " fzf
    Plug 'junegunn/fzf', { 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
" }}}

" Vim visuals {{{
    " rainbows
    Plug 'junegunn/rainbow_parentheses.vim'
    " Git
    Plug 'airblade/vim-gitgutter'
" }}}

" Omnicompletion {{{
" }}}

" lang {{{
    " Clojure
    Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }
    Plug 'guns/vim-clojure-static',         { 'for': 'clojure' }
    Plug 'guns/vim-clojure-highlight',      { 'for': 'clojure' }
    Plug 'bhurlow/vim-parinfer',            { 'for': ['clojure', 'scheme', 'lisp'] }

    " Javascript
    Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }

    " Go
    Plug 'fatih/vim-go',                    { 'for': 'go', 'do': ':GoInstallBinaries' }

    " Data
    Plug 'honza/dockerfile.vim'
" }}}

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

filetype plugin indent on

