" Project Navigation
"

" Ignore certain files and directories while searching
call unite#custom#source('file,file_rec,file_rec/async,grep',
      \ 'ignore_pattern', join([
      \ '\.git/',
      \ '\.bundle/',
      \ '\.rubygems/',
      \ 'vendor/',
      \ 'node_modules/',
      \ 'bower_components/',
      \ '.pulp-cache/',
      \ 'elm-stuff/',
      \ 'output/',
      \ '\.meta$',
      \ '\.ctrlp$',
      \ '\.swp$',
      \ '\.swo$',
      \ '\.DS_Store$',
      \ '\.silp_backup/',
      \ '\.silp_test/',
      \ '\.beam$',
      \ '\.pyc$',
      \ '\.ttf$',
      \ '\.png$',
      \ '\.jpg$',
      \ ], '\|'))

call unite#custom#source(
      \ 'file_rec/async,file_rec,file_mru,buffer,quickfix', 'matchers',
      \ ['converter_tail', 'matcher_default'])
call unite#custom#source(
      \ 'file_rec/async,file_rec,file_mru,buffer', 'converters',
      \ ['converter_file_directory'])
call unite#custom#source('file,file/new',
      \ 'matchersers', 'matcher_fuzzy')

" Not showing the trailing space as red if has vim-trailing-color installed
autocmd InsertLeave <buffer> match ExtraWhitespace //
autocmd InsertEnter <buffer> match ExtraWhitespace //
autocmd BufWinEnter <buffer> match ExtraWhitespace //
autocmd WinEnter <buffer> setlocal nocursorcolumn

" Play nice with supertab
let b:SuperTabDisabled=1

" Enable navigation with control-j and control-k in insert mode
imap <buffer> <C-j>   <Plug>(unite_select_next_line)
imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
imap <buffer> <C-c>   <Plug>(unite_exit)
nmap <buffer> <C-c>   <Plug>(unite_exit)
nmap <buffer> <BS>    <Plug>(unite_exit)

" vim:set ft=vim:
