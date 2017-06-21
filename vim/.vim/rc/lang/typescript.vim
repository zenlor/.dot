""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'leafgarland/typescript-vim',      { 'for': 'typescript' }
Plug 'HerringtonDarkholme/yats.vim',    { 'for': 'typescript' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.ts,*.tsx setlocal filetype=typescript

" vim:set ft=vim:
