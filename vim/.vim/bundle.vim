filetype off

call plug#begin(has('nvim') ? '~/.config/nvim/bundle' : '~/.vim/bundle')

" Essentials {{{
    Plug 'Shougo/vimproc', { 'do': 'make' }
    Plug 'editorconfig/editorconfig-vim'

    " Git
    Plug 'tpope/vim-fugitive'       " git in vim
    Plug 'airblade/vim-gitgutter'

    Plug 'notalex/vim-run-live'     " Running code inline
    Plug 'sheerun/vim-polyglot'     " support for a variety of languages
" }}}

" Vim functionality fixes/enhancements {{{
    Plug 'tpope/vim-repeat'         " better repeat compatibility ('.')
    Plug 'tpope/vim-commentary'     " comment things
    Plug 'vim-scripts/vis'          " improved visual commands
    Plug 'moll/vim-bbye'            " kill buffers without affecting window layout
    Plug 'justinmk/vim-sneak'       " 2-character search motions
    Plug 'tpope/vim-surround'       " manipulation of surrounding delimiters

    Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' } " tagbar
" }}}

" Omnicompletion

" lang {{{
    " Clojure
    Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }
    Plug 'guns/vim-clojure-static',         { 'for': 'clojure' }
    Plug 'guns/vim-clojure-highlight',      { 'for': 'clojure' }
    Plug 'venantius/vim-cljfmt',            { 'for': 'clojure' }
    Plug 'bhurlow/vim-parinfer',            { 'for': ['clojure', 'scheme', 'lisp'] }

    " Javascript
    Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }

    " Go
    Plug 'fatih/vim-go',                    { 'for': 'go', 'do': ':GoInstallBinaries' }

    " Data
    Plug 'honza/dockerfile.vim'

    " Lint
    Plug 'w0rp/ale'
" }}}

" Tmux {{{
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'benmills/vimux'
" }}}

" Theme
Plug 'tomasr/molokai'

call plug#end()
filetype plugin indent on

