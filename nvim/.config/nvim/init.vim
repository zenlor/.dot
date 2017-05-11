" dein.vim {{{
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/usr/share/vim/vimfiles/
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " The Dark (n)vimLord
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('Shougo/unite-session')
  call dein#add('Shougo/neocomplete.vim')
  call dein#config('neocomplete.vim', { 'lazy' : 1, 'on_i' : 1 })
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  " tpope
  call dein#add('tpope/vim-sensible')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-ragtag')
  call dein#add('tpope/vim-vinegar')
  call dein#add('tpope/vim-sleuth')
  call dein#add('tpope/vim-surround')

  " rainbows everywhere
  call dein#add('kien/rainbow_parentheses.vim')

  " gruvbox
  call dein#add('morhetz/gruvbox')

  " sneaky
  call dein#add('justinmk/vim-sneak')

  " supertab
  call dein#add('ervandew/supertab')

  " syntastic
  call dein#add('scrooloose/syntastic')
  call dein#config('syntastic', { 'lazy': 1, 'on_i': 1 })

  " eleline
  call dein#add('liuchengxu/eleline.vim')

  " brackets and '
  call dein#add('cohama/lexima.vim')

  " golder ratio splits
  call dein#add('roman/golden-ratio')

  """""""""""""
  " filetypes "
  """""""""""""

  "" clojure
  call dein#add('tpope/vim-fireplace')
  call dein#config('vim-fireplace', { 'lazy': 1, 'on_ft': 'clojure' })
  call dein#add('bhurlow/vim-parinfer')
  call dein#config('vim-parinfer', { 'lazy': 1, 'on_ft': 'clojure' })
  
  "" rust
  call dein#add('rust-lang/rust.vim', { 'lazy': 1, 'on_ft': 'rust' })
  "" javascript
  call dein#add('othree/yajs')
  call dein#config('yajs', { 'lazy': 1, 'on_ft': 'javascript' })
  "" typescript
  call dein#add('leafgarland/typescript-vim')
  call dein#config('typescript-vim', { 'lazy': 1, 'on_ft': 'typescript' })
  """ javascript + typescript
  " call dein#add('jason0x43/vim-js-indent')
  " call dein#config('vim-js-indent', { 'lazy': 1, 'on_ft': ['typescript', 'javascript'] })
  "" toml
  call dein#add('cespare/vim-toml')
  call dein#config('vim-toml', { 'lazy': 1, 'on_ft': 'toml' })
  "" go
  call dein#add('fatih/vim-go')
  call dein#config('vim-go', { 'lazy': 1, 'on_ft': 'go' })
  "" typescript
  call dein#add('leafgarland/typescript-vim')
  call dein#config('typescript-vim', { 'lazy': 1, 'on_ft': 'typescript' })
  call dein#add('Quramy/tsuquyomi')
  call dein#config('tsuquyomi', { 'lazy': 1, 'on_ft': 'typescript' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
" }}}

"
" Unite.vim
" {{{

let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
endfunction
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif
" }}}

" nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
" nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
" nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
" nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
" nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
" nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

"
" SpaceVim
" {{{
let mapleader = "\<SPACE>"

" files
nmap <LEADER>fa :<C-u>Unite buffer history/yank file file_rec/async file_mru<cr>
nmap <LEADER>ff :<C-u>Unite file file_rec/async file_mru<cr>
nmap <LEADER>fr :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nmap <LEADER>fs :w<CR>
nmap <LEADER>fS :wa<CR>

" buffers
nmap <LEADER>bb :<C-u>Unite -buffer-name=buffers -no-split buffer<CR>
nmap <LEADER>bd :bdelete<CR>
nmap <LEADER>bn :bn<CR>
nmap <LEADER>bp :bp<CR>
nmap <LEADER>bR :e<CR>

" commenting
nmap <Leader>;  <Plug>Commentary
vmap <Leader>;  <Plug>Commentary
omap <Leader>;  <Plug>Commentary
nmap <Leader>;; <Plug>CommentaryLine

" Git
nmap <LEADER>gb :Gblame<CR>
nmap <LEADER>gd :Gdiff<CR>
nmap <LEADER>gs :Gstatus<CR>
nmap <LEADER>gw :Gwrite<CR>
nmap <LEADER>gp :Git push<CR>
nmap <LEADER>gc :Gcommit<CR>
nmap <LEADER>gt :GitGutterToggle<CR>

" windows
nmap <LEADER>w- :sp<CR>
nmap <LEADER>w/ :vsp<CR>
nmap <LEADER>w= <C-W>=
nmap <LEADER>wc :q<CR>
nmap <LEADER>wh <C-W>h
nmap <LEADER>wj <C-W>j
nmap <LEADER>wk <C-W>k
nmap <LEADER>wl <C-W>l
nmap <LEADER>ws <C-W>s
nmap <LEADER>wv <C-W>v
nmap <LEADER>ww <C-W><C-W>

" Toggle show/hide invisible chars
nnoremap <LEADER>i :set list!<cr>
" Toggle line numbers
nnoremap <LEADER>N :setlocal number!<cr>
" reindent
nnoremap <Leader>j= mzgg=G`z
" clear search
nnoremap <Leader>sc :noh<CR>
" }}}

"
" file types
"{{{
autocmd FileType c setlocal noet ts=8 sw=8 tw=80
autocmd FileType h setlocal noet ts=8 sw=8 tw=80
autocmd FileType s setlocal noet ts=8 sw=8
autocmd FileType go setlocal noet ts=4 sw=4
autocmd FileType hy setlocal filetype=lisp
autocmd BufRead,BufNewFile *.js setlocal et ts=4 sw=4
"}}}

"
" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
"{{{
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END
" }}}

"
" Typescript
"
let g:typescript_indent_disable = 1

"
" Syntastic
"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_eslint_exec = '~/lib/n/bin/eslint'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['go']}

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

"
" create directories with :mk
"
cnoremap mk. !mkdir -p <c-r>=expand("%:h")<cr>/

"
" Save with sudo tee ...
"
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

"
" save and reload positions of re-opened files
"
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

"
" Clipboard
"
" copy to system clipboard with C-c in visual mode
vnoremap <C-c> "*y

"
" theme
"
let g:gruvbox_italic = 1
set termguicolors
set t_Co=256
set background=dark
colorscheme spacevim
