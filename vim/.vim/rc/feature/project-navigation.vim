" Project Navigation
"
" These plugins/settings make navigating and searching code and project files
" simpler.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Shougo/unite.vim'               " Unite and create user interfaces
Plug 'Shougo/vimfiler.vim'

" File searching
if executable('fzf')
  Plug 'junegunn/fzf'
elseif executable('ag')
  Plug 'rking/ag.vim'
elseif executable('ack')
  Plug 'mileszs/ack.vim'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vimfiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

nnoremap - :VimFiler<cr>


" fzf
if executable('fzf')
  command! FZFMru call fzf#run({
        \  'source':  v:oldfiles,
        \  'sink':    'e',
        \  'options': '-m -x +s',
        \  'down':    '40%'})

  nnoremap <C-f> :FZF<CR>
  nnoremap <C-m> :FZFMru<CR>
endif

" Unite

let g:unite_data_directory='~/.cache/vim-unite'
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --line-numbers --nogroup -S'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color'
  let g:unite_source_grep_recursive_opt=''
endif

let g:unite_quick_match_table = {
      \ '1' : 0, '2' : 1, '3' : 2, '4' : 3, '5' : 4, '6' : 5, '7' : 6, '8' : 7, '9' : 8, '0' : 9,
      \ 'a' : 10, 's' : 11, 'd' : 12, 'f' : 13, 'g' : 14, 'h' : 15, 'j' : 16, 'k' : 17, 'l' : 18, ';' : 19,
      \ 'q' : 20, 'w' : 21, 'e' : 22, 'r' : 23, 't' : 24, 'y' : 25, 'u' : 26, 'i' : 27, 'o' : 28, 'p' : 29
      \ }

" call unite#filters#sorter_default#use(['sorter_rank'])
" call unite#filters#matcher_default#use(['matcher_fuzzy'])

" http://www.codeography.com/2013/06/17/replacing-all-the-things-with-unite-vim.html
" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
" -auto-preview

" Note: <C-u> here can remove range
"nnoremap ,p :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
"

" Ctrl P
nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>

" Unite buffer
nnoremap ,<Space> :<C-u>Unite -no-quit -buffer-name=unite 

if has('win32') || has('win64')
  nnoremap ,p :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec<cr>
else
  nnoremap ,p :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async<cr>
endif

nnoremap ,' :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nnoremap ,, :<C-u>Unite -no-split -buffer-name=buffer -start-insert buffer<cr>
nnoremap ,r :<C-u>Unite -no-split -buffer-name=register -default-action=yank -auto-quit register<cr>
nnoremap ,t :<C-u>Unite -no-split -buffer-name=tag -start-insert tag<cr>
nnoremap ,g :<C-u>Unite -no-split -buffer-name=bookmark -start-insert bookmark<cr>

"Not really using
nnoremap ,o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap ,y :<C-u>Unite -no-split -buffer-name=yank -quick-match history/yank<cr>

" Search with ag
noremap <silent> ,. :<C-u>Unite -no-quit -buffer-name=grep grep:.:<CR>
" For searching the word in the cursor in the current buffer,
noremap <silent> ,f :<C-u>Unite -no-quit -buffer-name=grep grep:.:<CR><C-r><C-w><CR>

" showing quickfix with error only (mainly for the omnisharp build result for now)
noremap <silent> ,x :<C-u>Unite -no-quit -buffer-name=quickfix -start-insert quickfix<CR>error

" For searching the word in the cursor in all opened buffer
" noremap <silent> <Leader>sa :Unite grep:$buffers::<C-r><C-w><CR>


" vim:set ft=vim:
