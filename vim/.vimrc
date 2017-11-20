" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ============================================================================
" .vimrc {{{
" ============================================================================

" Vim 8 defaults
unlet! skip_defaults_vim
silent! source $VIMRUNTIME/defaults.vim

" }}}
" ============================================================================
" VIM-PLUG BLOCK {{{
" ============================================================================

silent! if plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/gv.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/heytmux'

" Colors
Plug 'tomasr/molokai'

" Misc
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-vinegar'

" Edit
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'sgur/vim-editorconfig'

" Completion: deoplete.vim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Completion integration with nvim-completion-manager.
Plug 'roxma/nvim-completion-manager'
" Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'

" languages
"
" generic
Plug 'Shougo/neco-syntax'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
" vimL
Plug 'Shougo/neco-vim'
" clojure
Plug 'clojure-vim/async-clj-omni',    { 'for': 'clojure' }
" javascript tern
Plug 'carlitux/deoplete-ternjs',      { 'for': 'javascript', 'do': 'npm install -g tern' }
" typescript tsserver
Plug 'mhartington/nvim-typescript',   { 'for': 'typescript' }
"
" Browsing
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
autocmd! User indentLine doautocmd indentLine Syntax

Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
Plug 'justinmk/vim-gtfo'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Lang
Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }
Plug 'guns/vim-clojure-static',         { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight',      { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt',            { 'for': 'clojure' }
Plug 'bhurlow/vim-parinfer',            { 'for': ['clojure', 'scheme', 'lisp'] }
Plug 'guns/vim-slamhound'
Plug 'fatih/vim-go',                    { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'pangloss/vim-javascript',         { 'for': 'javascript' }
Plug 'mxw/vim-jsx',                     { 'for': 'javascript' }
Plug 'rust-lang/rust.vim',              { 'for': 'rust' }
Plug 'derekwyatt/vim-scala',            { 'for': 'scala' }
Plug 'honza/dockerfile.vim'
Plug 'solarnz/thrift.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'lyuts/vim-rtags',                 { 'for': ['c', 'cpp'] }

" Lint
Plug 'w0rp/ale'

call plug#end()
endif

" }}}
" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================

let mapleader      = ' '
let maplocalleader = ' '

augroup vimrc
  autocmd!
augroup END

set nu
set autoindent
set smartindent
set lazyredraw
set laststatus=2
set showcmd
set visualbell
set backspace=indent,eol,start
set timeoutlen=500
set whichwrap=b,s
set shortmess=aIT
set hlsearch " CTRL-L / CTRL-R W
set incsearch
set hidden
set ignorecase smartcase
set wildmenu
set wildmode=full
set tabstop=2
set shiftwidth=2
set expandtab smarttab
set scrolloff=5
set encoding=utf-8
set list
set listchars=tab:\|\ ,
set virtualedit=block
set nojoinspaces
set diffopt=filler,vertical
set autoread
set clipboard=unnamed
set foldlevelstart=99
set grepformat=%f:%l:%c:%m,%f:%l:%m
set completeopt=menuone,preview
set nocursorline
set nrformats=hex
silent! set cryptmethod=blowfish2

set formatoptions+=1
if has('patch-7.3.541')
  set formatoptions+=j
endif
if has('patch-7.4.338')
  let &showbreak = '↳ '
  set breakindent
  set breakindentopt=sbr
endif

set pastetoggle=<F9>
set modelines=2
set synmaxcol=1000

set tags=./tags;/

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" Shift-tab on GNU screen
" http://superuser.com/questions/195794/gnu-screen-shift-tab-issue
set t_kB=[Z

" set complete=.,w,b,u,t
set complete-=i

" mouse
silent! set ttymouse=xterm2
set mouse=a

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=81
endif

" Keep the cursor on the same column
set nostartofline

" FOOBAR=~/<CTRL-><CTRL-F>
set isfname-==

if exists('&fixeol')
  set nofixeol
endif

" Colorscheme
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
set background=dark
set t_Co=256
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

if has('gui_running')
  set guifont=Menlo:h14 columns=80 lines=40
  silent! colo seoul256-light
else
  silent! colo seoul256
endif

" }}}
" ============================================================================
" MAPPINGS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" Basic mappings
" ----------------------------------------------------------------------------

noremap <C-F> <C-D>
noremap <C-B> <C-U>

" Save
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" Quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Tags
nnoremap <C-]> g<C-]>
nnoremap g[ :pop<cr>

" Jump list (to newer position)
nnoremap <C-p> <C-i>

" <F10> | NERD Tree
nnoremap <F10> :NERDTreeToggle<cr>

" <F11> | Tagbar
if v:version >= 703
  inoremap <F11> <esc>:TagbarToggle<cr>
  nnoremap <F11> :TagbarToggle<cr>
  let g:tagbar_sort = 0
endif

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Movement in insert mode
inoremap <C-h> <C-o>h
inoremap <C-l> <C-o>a
inoremap <C-j> <C-o>j
inoremap <C-k> <C-o>k
inoremap <C-^> <C-o><C-^>

" Make Y behave like other capitals
nnoremap Y y$

" qq to record, Q to replay
nnoremap Q @q

" Zoom
function! s:zoom()
  if winnr('$') > 1
    tab split
  elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                  \ 'index(v:val, '.bufnr('').') >= 0')) > 1
    tabclose
  endif
endfunction
nnoremap <silent> <leader>z :call <sid>zoom()<cr>

" Last inserted text
nnoremap g. :normal! `[v`]<cr><left>

" ----------------------------------------------------------------------------
" nvim
" ----------------------------------------------------------------------------
if has('nvim')
  tnoremap <a-a> <esc>a
  tnoremap <a-b> <esc>b
  tnoremap <a-d> <esc>d
  tnoremap <a-f> <esc>f
endif

" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
nnoremap <tab>   <c-w>w
nnoremap <S-tab> <c-w>W

" ----------------------------------------------------------------------------
" tmux
" ----------------------------------------------------------------------------
function! s:tmux_send(content, dest) range
  let dest = empty(a:dest) ? input('To which pane? ') : a:dest
  let tempfile = tempname()
  call writefile(split(a:content, "\n", 1), tempfile, 'b')
  call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
        \ shellescape(tempfile), shellescape(dest)))
  call delete(tempfile)
endfunction

function! s:tmux_map(key, dest)
  execute printf('nnoremap <silent> %s "tyy:call <SID>tmux_send(@t, "%s")<cr>', a:key, a:dest)
  execute printf('xnoremap <silent> %s "ty:call <SID>tmux_send(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call s:tmux_map('<leader>tt', '')
call s:tmux_map('<leader>th', '.left')
call s:tmux_map('<leader>tj', '.bottom')
call s:tmux_map('<leader>tk', '.top')
call s:tmux_map('<leader>tl', '.right')
call s:tmux_map('<leader>ty', '.top-left')
call s:tmux_map('<leader>to', '.top-right')
call s:tmux_map('<leader>tn', '.bottom-left')
call s:tmux_map('<leader>t.', '.bottom-right')

" ----------------------------------------------------------------------------
" <tab> / <s-tab> / <c-v><tab> | super-duper-tab
" ----------------------------------------------------------------------------
function! s:can_complete(func, prefix)
  if empty(a:func)
    return 0
  endif
  let start = call(a:func, [1, ''])
  if start < 0
    return 0
  endif

  let oline  = getline('.')
  let line   = oline[0:start-1] . oline[col('.')-1:]

  let opos   = getpos('.')
  let pos    = copy(opos)
  let pos[2] = start + 1

  call setline('.', line)
  call setpos('.', pos)
  let result = call(a:func, [0, matchstr(a:prefix, '\k\+$')])
  call setline('.', oline)
  call setpos('.', opos)

  if !empty(type(result) == type([]) ? result : result.words)
    call complete(start + 1, result)
    return 1
  endif
  return 0
endfunction

function! s:feedkeys(k)
  call feedkeys(a:k, 'n')
  return ''
endfunction

function! s:super_duper_tab(pumvisible, next)
  let [k, o] = a:next ? ["\<c-n>", "\<tab>"] : ["\<c-p>", "\<s-tab>"]
  if a:pumvisible
    return s:feedkeys(k)
  endif

  let line = getline('.')
  let col = col('.') - 2
  if line[col] !~ '\k\|[/~.]'
    return s:feedkeys(o)
  endif

  let prefix = expand(matchstr(line[0:col], '\S*$'))
  if prefix =~ '^[~/.]'
    return s:feedkeys("\<c-x>\<c-f>")
  endif
  if s:can_complete(&omnifunc, prefix) || s:can_complete(&completefunc, prefix)
    return ''
  endif
  return s:feedkeys(k)
endfunction

inoremap <silent> <tab>   <c-r>=<SID>super_duper_tab(pumvisible(), 1)<cr>
inoremap <silent> <s-tab> <c-r>=<SID>super_duper_tab(pumvisible(), 0)<cr>

" ----------------------------------------------------------------------------
" Markdown headings
" ----------------------------------------------------------------------------
nnoremap <leader>1 m`yypVr=``
nnoremap <leader>2 m`yypVr-``
nnoremap <leader>3 m`^i### <esc>``4l
nnoremap <leader>4 m`^i#### <esc>``5l
nnoremap <leader>5 m`^i##### <esc>``6l

" ----------------------------------------------------------------------------
" Moving lines
" ----------------------------------------------------------------------------
nnoremap <silent> <C-k> :move-2<cr>
nnoremap <silent> <C-j> :move+<cr>
nnoremap <silent> <C-h> <<
nnoremap <silent> <C-l> >>
xnoremap <silent> <C-k> :move-2<cr>gv
xnoremap <silent> <C-j> :move'>+<cr>gv
xnoremap <silent> <C-h> <gv
xnoremap <silent> <C-l> >gv
xnoremap < <gv
xnoremap > >gv

" ----------------------------------------------------------------------------
" <Leader>c Close quickfix/location window
" ----------------------------------------------------------------------------
nnoremap <leader>c :cclose<bar>lclose<cr>

" ----------------------------------------------------------------------------
" Readline-style key bindings in command-line (excerpt from rsi.vim)
" ----------------------------------------------------------------------------
cnoremap        <C-A> <Home>
cnoremap        <C-B> <Left>
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap        <M-b> <S-Left>
cnoremap        <M-f> <S-Right>
silent! exe "set <S-Left>=\<Esc>b"
silent! exe "set <S-Right>=\<Esc>f"

" ----------------------------------------------------------------------------
" #gi / #gpi | go to next/previous indentation level
" ----------------------------------------------------------------------------
function! s:go_indent(times, dir)
  for _ in range(a:times)
    let l = line('.')
    let x = line('$')
    let i = s:indent_len(getline(l))
    let e = empty(getline(l))

    while l >= 1 && l <= x
      let line = getline(l + a:dir)
      let l += a:dir
      if s:indent_len(line) != i || empty(line) != e
        break
      endif
    endwhile
    let l = min([max([1, l]), x])
    execute 'normal! '. l .'G^'
  endfor
endfunction
nnoremap <silent> gi :<c-u>call <SID>go_indent(v:count1, 1)<cr>
nnoremap <silent> gpi :<c-u>call <SID>go_indent(v:count1, -1)<cr>

" ----------------------------------------------------------------------------
" <leader>bs | buf-search
" ----------------------------------------------------------------------------
nnoremap <leader>bs :cex []<BAR>bufdo vimgrepadd @@g %<BAR>cw<s-left><s-left><right>

" ----------------------------------------------------------------------------
" #!! | Shebang
" ----------------------------------------------------------------------------
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)

" ----------------------------------------------------------------------------
" Heytmux
" ----------------------------------------------------------------------------

xnoremap <leader>ht :Heytmux<cr>

" }}}
" ============================================================================
" FUNCTIONS & COMMANDS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" :NL
" ----------------------------------------------------------------------------
command! -range=% -nargs=1 NL
  \ <line1>,<line2>!nl -w <args> -s '. ' | perl -pe 's/^.{<args>}..$//'

" ----------------------------------------------------------------------------
" :Chomp
" ----------------------------------------------------------------------------
command! Chomp %s/\s\+$// | normal! ``

" ----------------------------------------------------------------------------
" :Count
" ----------------------------------------------------------------------------
command! -nargs=1 Count execute printf('%%s/%s//gn', escape(<q-args>, '/')) | normal! ``

" ----------------------------------------------------------------------------
" :M
" ----------------------------------------------------------------------------
command! M execute printf('!bundle exec m %s:%d', expand('%'), line('.'))

" ----------------------------------------------------------------------------
" :Root | Change directory to the root of the Git repository
" ----------------------------------------------------------------------------
function! s:root()
  let root = systemlist('git rev-parse --show-toplevel')[0]
  if v:shell_error
    echo 'Not in git repo'
  else
    execute 'lcd' root
    echo 'Changed directory to: '.root
  endif
endfunction
command! Root call s:root()

" ----------------------------------------------------------------------------
" <F5> / <F6> | Run script
" ----------------------------------------------------------------------------
function! s:run_this_script(output)
  let head   = getline(1)
  let pos    = stridx(head, '#!')
  let file   = expand('%:p')
  let ofile  = tempname()
  let rdr    = " 2>&1 | tee ".ofile
  let win    = winnr()
  let prefix = a:output ? 'silent !' : '!'
  " Shebang found
  if pos != -1
    execute prefix.strpart(head, pos + 2).' '.file.rdr
  " Shebang not found but executable
  elseif executable(file)
    execute prefix.file.rdr
  elseif &filetype == 'tex'
    execute prefix.'latex '.file. '; [ $? -eq 0 ] && xdvi '. expand('%:r').rdr
  elseif &filetype == 'dot'
    let svg = expand('%:r') . '.svg'
    let png = expand('%:r') . '.png'
    " librsvg >> imagemagick + ghostscript
    execute 'silent !dot -Tsvg '.file.' -o '.svg.' && '
          \ 'rsvg-convert -z 2 '.svg.' > '.png.' && open '.png.rdr
  else
    return
  end
  redraw!
  if !a:output | return | endif

  " Scratch buffer
  if exists('s:vim_exec_buf') && bufexists(s:vim_exec_buf)
    execute bufwinnr(s:vim_exec_buf).'wincmd w'
    %d
  else
    silent!  bdelete [vim-exec-output]
    silent!  vertical botright split new
    silent!  file [vim-exec-output]
    setlocal buftype=nofile bufhidden=wipe noswapfile
    let      s:vim_exec_buf = winnr()
  endif
  execute 'silent! read' ofile
  normal! gg"_dd
  execute win.'wincmd w'
endfunction
nnoremap <silent> <F5> :call <SID>run_this_script(0)<cr>
nnoremap <silent> <F6> :call <SID>run_this_script(1)<cr>

" ----------------------------------------------------------------------------
" SaveMacro / LoadMacro
" ----------------------------------------------------------------------------
function! s:save_macro(name, file)
  let content = eval('@'.a:name)
  if !empty(content)
    call writefile(split(content, "\n"), a:file)
    echom len(content) . " bytes save to ". a:file
  endif
endfunction
command! -nargs=* SaveMacro call <SID>save_macro(<f-args>)

function! s:load_macro(file, name)
  let data = join(readfile(a:file), "\n")
  call setreg(a:name, data, 'c')
  echom "Macro loaded to @". a:name
endfunction
command! -nargs=* LoadMacro call <SID>load_macro(<f-args>)

" ----------------------------------------------------------------------------
" HL | Find out syntax group
" ----------------------------------------------------------------------------
function! s:hl()
  " echo synIDattr(synID(line('.'), col('.'), 0), 'name')
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), '/')
endfunction
command! HL call <SID>hl()

" ----------------------------------------------------------------------------
" :A
" ----------------------------------------------------------------------------
function! s:a(cmd)
  let name = expand('%:r')
  let ext = tolower(expand('%:e'))
  let sources = ['c', 'cc', 'cpp', 'cxx']
  let headers = ['h', 'hh', 'hpp', 'hxx']
  for pair in [[sources, headers], [headers, sources]]
    let [set1, set2] = pair
    if index(set1, ext) >= 0
      for h in set2
        let aname = name.'.'.h
        for a in [aname, toupper(aname)]
          if filereadable(a)
            execute a:cmd a
            return
          end
        endfor
      endfor
    endif
  endfor
endfunction
command! A call s:a('e')
command! AV call s:a('botright vertical split')

" ----------------------------------------------------------------------------
" Todo
" ----------------------------------------------------------------------------
function! s:todo() abort
  let entries = []
  for cmd in ['git grep -niI -e TODO -e FIXME -e XXX 2> /dev/null',
            \ 'grep -rniI -e TODO -e FIXME -e XXX * 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor

  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction
command! Todo call s:todo()

" ----------------------------------------------------------------------------
" AutoSave
" ----------------------------------------------------------------------------
function! s:autosave(enable)
  augroup autosave
    autocmd!
    if a:enable
      autocmd TextChanged,InsertLeave <buffer>
            \  if empty(&buftype) && !empty(bufname(''))
            \|   silent! update
            \| endif
    endif
  augroup END
endfunction

command! -bang AutoSave call s:autosave(<bang>1)

" ----------------------------------------------------------------------------
" Profile
" ----------------------------------------------------------------------------
function! s:profile(bang)
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction
command! -bang Profile call s:profile(<bang>0)

" ----------------------------------------------------------------------------
" co? : Toggle options (inspired by unimpaired.vim)
" ----------------------------------------------------------------------------
function! s:map_change_option(...)
  let [key, opt] = a:000[0:1]
  let op = get(a:, 3, 'set '.opt.'!')
  execute printf("nnoremap co%s :%s<bar>set %s?<cr>", key, op, opt)
endfunction

call s:map_change_option('p', 'paste')
call s:map_change_option('n', 'number')
call s:map_change_option('w', 'wrap')
call s:map_change_option('h', 'hlsearch')
call s:map_change_option('m', 'mouse', 'let &mouse = &mouse == "" ? "a" : ""')
call s:map_change_option('t', 'textwidth',
    \ 'let &textwidth = input("textwidth (". &textwidth ."): ")<bar>redraw')
call s:map_change_option('b', 'background',
    \ 'let &background = &background == "dark" ? "light" : "dark"<bar>redraw')


" }}}
" ============================================================================
" PLUGINS {{{
" ============================================================================

" ----------------------------------------------------------------------------
" MatchParen delay
" ----------------------------------------------------------------------------
let g:matchparen_insert_timeout=5

" ----------------------------------------------------------------------------
" vim-commentary
" ----------------------------------------------------------------------------
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" ----------------------------------------------------------------------------
" vim-fugitive
" ----------------------------------------------------------------------------
nmap     <Leader>g :Gstatus<CR>gg<c-n>
nnoremap <Leader>d :Gdiff<CR>

" ----------------------------------------------------------------------------
" matchit.vim
" ----------------------------------------------------------------------------
runtime macros/matchit.vim

" ----------------------------------------------------------------------------
" ack.vim
" ----------------------------------------------------------------------------
if executable('ag')
  let &grepprg = 'ag --nogroup --nocolor --column'
else
  let &grepprg = 'grep -rn $* *'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

" ----------------------------------------------------------------------------
" vim-after-object
" ----------------------------------------------------------------------------
silent! if has_key(g:plugs, 'vim-after-object')
  autocmd VimEnter * silent! call after_object#enable('=', ':', '#', ' ', '|')
endif

" ----------------------------------------------------------------------------
" <Enter> | vim-easy-align
" ----------------------------------------------------------------------------
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

" Start interactive EasyAlign in visual mode
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign with a Vim movement
nmap ga <Plug>(EasyAlign)
nmap gaa ga_

xmap <Leader>ga   <Plug>(LiveEasyAlign)
" nmap <Leader><Leader>a <Plug>(LiveEasyAlign)

" inoremap <silent> => =><Esc>mzvip:EasyAlign/=>/<CR>`z$a<Space>

" ----------------------------------------------------------------------------
" indentLine
" ----------------------------------------------------------------------------
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'

" ----------------------------------------------------------------------------
" vim-slash
" ----------------------------------------------------------------------------
if has('timers') && !has('nvim')
  noremap <expr> <plug>(slash-after) slash#blink(2, 50)
endif

" ----------------------------------------------------------------------------
" vim-emoji :dog: :cat: :rabbit:!
" ----------------------------------------------------------------------------
command! -range EmojiReplace <line1>,<line2>s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g

" ----------------------------------------------------------------------------
" goyo.vim + limelight.vim
" ----------------------------------------------------------------------------
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

function! s:goyo_enter()
  if has('gui_running')
    set fullscreen
    set background=light
    set linespace=7
  elseif exists('$TMUX')
    silent !tmux set status off
  endif
  Limelight
  let &l:statusline = '%M'
  hi StatusLine ctermfg=red guifg=red cterm=NONE gui=NONE
endfunction

function! s:goyo_leave()
  if has('gui_running')
    set nofullscreen
    set background=dark
    set linespace=0
  elseif exists('$TMUX')
    silent !tmux set status on
  endif
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <Leader>G :Goyo<CR>

" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
let g:ale_linters = {'java': [], 'yaml': [], 'scala': []}
let g:ale_lint_delay = 1000
nmap ]a <Plug>(ale_next_wrap)
nmap [a <Plug>(ale_previous_wrap)

" brew install candid82/brew/joker
command! Joker call ale#linter#Define('clojure', {
\   'name': 'joker',
\   'executable': 'joker',
\   'command': 'joker --lint %t 2>&1',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\}) | ALEDisable | ALEEnable

" ----------------------------------------------------------------------------
" gv.vim / gl.vim
" ----------------------------------------------------------------------------
function! s:gv_expand()
  let line = getline('.')
  GV --name-status
  call search('\V'.line, 'c')
  normal! zz
endfunction

autocmd! FileType GV nnoremap <buffer> <silent> + :call <sid>gv_expand()<cr>

" ----------------------------------------------------------------------------
" undotree
" ----------------------------------------------------------------------------
let g:undotree_WindowLayout = 2
nnoremap U :UndotreeToggle<CR>

" ----------------------------------------------------------------------------
" clojure
" ----------------------------------------------------------------------------
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
let g:paredit_smartjump = 1

" vim-cljfmt
let g:clj_fmt_autosave = 0
autocmd vimrc BufWritePre *.clj call cljfmt#AutoFormat()
autocmd vimrc BufWritePre *.cljc call cljfmt#AutoFormat()

" ----------------------------------------------------------------------------
" vim-markdown
" ----------------------------------------------------------------------------
" let g:markdown_fenced_languages = ['sh', 'clojure', 'vim', 'java', 'gnuplot']

" ----------------------------------------------------------------------------
" splitjoin
" ----------------------------------------------------------------------------
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nnoremap gss :SplitjoinSplit<cr>
nnoremap gsj :SplitjoinJoin<cr>

" ----------------------------------------------------------------------------
" Denite/Deoplete
" ----------------------------------------------------------------------------
set omnifunc=syntaxcomplete#Complete
let g:deoplete#enable_at_startup = 1
set completeopt+=noinsert
let g:deoplete#enable_ignore_case = 'ignorecase'

"
" OmniCompletion
" https://github.com/Shougo/neocomplete.vim/blob/master/autoload/neocomplete/sources/omni.vim
"
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.html = '<[^>]*'
let g:deoplete#omni_patterns.xml  = '<[^>]*'
let g:deoplete#omni_patterns.md   = '<[^>]*'
let g:deoplete#omni_patterns.css   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni_patterns.scss   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni_patterns.sass   = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
let g:deoplete#omni_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'
let g:deoplete#omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:deoplete#omni_patterns.go = '[^.[:digit:] *\t]\.\w*'
" let g:deoplete#omni_patterns.python = '[^. \t]\.\w*'
let g:deoplete#omni_patterns.python = ['[^. *\t]\.\h\w*\','\h\w*::']
let g:deoplete#omni_patterns.python3 = ['[^. *\t]\.\h\w*\','\h\w*::']
autocmd CmdwinEnter * let b:deoplete_sources = ['buffer']

"
" keyword patterns
"
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.#]*'

"
" mapping
"
imap     <Nul> <C-Space>
inoremap <expr><C-Space> deoplete#mappings#manual_complete()
inoremap <expr><BS>      deoplete#mappings#smart_close_popup()."\<C-h>"


" ----------------------------------------------------------------------------
" airline
" ----------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1

" }}}
" ============================================================================
" FZF {{{
" ============================================================================

if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
  " let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>l        :Lines<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

function! s:plug_help_sink(line)
  let dir = g:plugs[a:line].dir
  for pat in ['doc/*.txt', 'README.md']
    let match = get(split(globpath(dir, pat), "\n"), 0, '')
    if len(match)
      execute 'tabedit' match
      return
    endif
  endfor
  tabnew
  execute 'Explore' dir
endfunction

command! PlugHelp call fzf#run(fzf#wrap({
  \ 'source': sort(keys(g:plugs)),
  \ 'sink':   function('s:plug_help_sink')}))

" }}}
" ============================================================================
" AUTOCMD {{{
" ============================================================================

augroup vimrc
  au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " IndentLines
  au FileType slim IndentLinesEnable

  " File types
  au BufNewFile,BufRead *.icc               set filetype=cpp
  au BufNewFile,BufRead *.pde               set filetype=java
  au BufNewFile,BufRead Dockerfile*         set filetype=dockerfile

  " Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

  " Unset paste on InsertLeave
  au InsertLeave * silent! set nopaste

  " Close preview window
  if exists('##CompleteDone')
    au CompleteDone * pclose
  else
    au InsertLeave * if !pumvisible() && (!exists('*getcmdwintype') || empty(getcmdwintype())) | pclose | endif
  endif

  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END

" }}}
