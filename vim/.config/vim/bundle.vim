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
    Plug 'moll/vim-bbye'            " kill buffers without affecting window layout
    Plug 'justinmk/vim-sneak'       " 2-character search motions
    Plug 'tpope/vim-surround'       " manipulation of surrounding delimiters
    Plug 'tpope/vim-vinegar'        " vinegar dressing for netrw
    Plug 'junegunn/vim-easy-align'

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
    Plug 'venantius/vim-cljfmt',            { 'for': 'clojure' }
    "Plug 'bhurlow/vim-parinfer',            { 'for': ['clojure', 'scheme', 'lisp'] }

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

" LightLine
Plug 'itchyny/lightline.vim'
Plug 'daviesjamie/vim-base16-lightline'

" Theme
Plug 'chriskempson/base16-vim'

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

filetype plugin indent on

