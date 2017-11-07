" Editor
"
" Making vim act more like a modern editor with autoclosing delimiters,
" typing things for me, more intelligent auto-commenting, etc.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/emodeline'         " read emacs modelines

Plug 'szw/vim-maximizer'             " toggling maximizing of a buffer
Plug 'justinmk/vim-sneak'            " 2-character search motions
Plug 'Raimondi/delimitMate'          " autoclose delimiters

Plug 'godlygeek/tabular'             " for aligning text
Plug 'tomtom/tcomment_vim'           " comment out code with native comment syntax
Plug 'tpope/vim-endwise'             " auto-end code blocks (e.g. for ruby or viml)
Plug 'tpope/vim-surround'            " manipulation of surrounding delimiters
Plug 'tpope/vim-sleuth'              " Heuristically set buffer options
Plug 'AndrewRadev/switch.vim'        " switching between true/false, yes/no, etc

Plug 'itchyny/lightline.vim'         " simple statusbar

Plug 'tpope/vim-fugitive'            " a Git wrapper so awesome, it should be illegal
Plug 'airblade/vim-gitgutter'        " visual git diffs in the gutter
Plug 'thinca/vim-visualstar'         " smarter * and #

Plug 'vim-scripts/PickAColor.vim'    " Color picker pop-up

Plug 'editorconfig/editorconfig-vim' " editorconfig

" Dash.app documentation (mac only)
if has('macunix')
    Plug 'rizzatti/dash.vim'
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-maximizer
let g:maximizer_set_default_mapping = 0
nnoremap <silent> <C-w>o :<C-u>MaximizerToggle!<CR>

" vim-sneak
let g:sneak#s_next = 1

" delimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" tcomment_vim
let g:tcomment_types = {'blade': '{-- %s --}', 'twig': '{# %s #}'}

" gitgutter
let g:gitgutter_eager = 0
set signcolumn=yes

" lightline
set laststatus=2
let g:lightline = {
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

"
au FileType text setl wrap linebreak formatoptions-=atc formatoptions+=l
au FileType snippet let b:endwise_addition='end&' | let b:endwise_words='snippet' | let b:endwise_syngroups='snippets,snipStart,snipKeyword'

"
au! BufNewFile,BufRead .spacemacs setf lisp

" Editorconfig excludes
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" vim:set ft=vim:
