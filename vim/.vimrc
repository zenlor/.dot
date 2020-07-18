set nocompatible

filetype off

call plug#begin('~/.cache/vim/bundle')

" Essentials {{{
    "Plug 'Shougo/vimproc', { 'do': 'make' }
    Plug 'editorconfig/editorconfig-vim'
" }}}

" Vim functionality fixes/enhancements {{{
    Plug 'tpope/vim-repeat'         " better repeat compatibility ('.')
    Plug 'tpope/vim-commentary'     " comment things
    Plug 'vim-scripts/vis'          " improved visual commands
    Plug 'justinmk/vim-sneak'       " 2-character search motions
    Plug 'tpope/vim-surround'       " manipulation of surrounding delimiters
    Plug 'tpope/vim-vinegar'        " vinegar dressing for netrw

    Plug 'jiangmiao/auto-pairs'

    " fzf
    Plug 'junegunn/fzf', { 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " project root finder
    Plug 'mattn/vim-findroot'

    " align easily
    Plug 'junegunn/vim-easy-align'
" }}}

" Vim visuals {{{
    " rainbows
    Plug 'junegunn/rainbow_parentheses.vim'
    " match parentheses
    Plug 'andymass/vim-matchup'
    " theme (?)
    Plug 'xero/sourcerer.vim'
" }}}

" lang {{{
    " Clojure
    Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }

    " Javascript
    Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }

    " Go
    Plug 'fatih/vim-go',                    { 'for': 'go', 'do': ':GoInstallBinaries' }

    " Data
    Plug 'honza/dockerfile.vim'

    " Rust
    Plug 'rust-lang/rust.vim'

    " Fennel
    Plug 'bakpakin/fennel.vim'

    " Janet
    Plug 'bakpakin/janet.vim'

    " C
    Plug 'WolfgangMehner/c-support',        { 'for': 'c' }

    " Terraform
    Plug 'hashivim/vim-terraform',          { 'for': 'terraform' }

" }}}

" lisps {{{
   Plug 'pyrmont/parinfer-rust',           { 'for': ['clojure', 'scheme', 'lisp', 'janet', 'fennel'],
                                           \ 'do': 'cargo build --release',
                                           \ 'branch': 'janet-support'}
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

" Custom code & extra configuration
runtime! rc/*/*.vim
runtime! rc/*.vim

" vim:set fdl=0 fdm=marker:
