""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'guns/vim-clojure-static',         { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight',      { 'for': 'clojure' }

Plug 'tpope/vim-fireplace',             { 'for': 'clojure' }
Plug 'tpope/vim-salve',                 { 'for': 'clojure' }
Plug 'tpope/vim-projectionist',         { 'for': 'clojure' }
Plug 'tpope/vim-dispatch',              { 'for': 'clojure' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" vim:set ft=vim:

