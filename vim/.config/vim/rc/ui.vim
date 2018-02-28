set background=light
set number           " Line numbers
set showcmd          " Show command issued
set fillchars=vert:│
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
set textwidth=81

" No background in terminal
if has("autocmd") && !has("gui_running")
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    " autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
end

" LightLine
let g:lightline = {
      \ 'colorscheme': 'base16',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive'],[ 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LLFugitive',
      \   'readonly': 'LLReadonly',
      \   'modified': 'LLModified',
      \   'filename': 'LLFilename',
      \   'mode': 'LLMode'
      \ }
      \ }

function! LLMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ lightline#mode() == 'NORMAL' ? 'N' :
        \ lightline#mode() == 'INSERT' ? 'I' :
        \ lightline#mode() == 'VISUAL' ? 'V' :
        \ lightline#mode() == 'V-LINE' ? 'V' :
        \ lightline#mode() == 'V-BLOCK' ? 'V' :
        \ lightline#mode() == 'REPLACE' ? 'R' : lightline#mode()
endfunction

function! LLModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LLReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "!"
  else
    return ""
  endif
endfunction

function! LLFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! LLFilename()
  return ('' != LLReadonly() ? LLReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LLModified() ? ' ' . LLModified() : '')
endfunction

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Colors
colorscheme base16-one-light
set background=light " or dark

" vim:set fdl=0 fdm=marker:
