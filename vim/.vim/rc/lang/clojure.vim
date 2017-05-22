""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let clj = [ 'clj', 'cljs', 'cljx', 'cljc' ]

Plug 'guns/vim-clojure-static',         { 'for': clj }
Plug 'guns/vim-clojure-highlight',      { 'for': clj }

Plug 'tpope/vim-fireplace',             { 'for': clj }
Plug 'tpope/vim-salve',                 { 'for': clj }
Plug 'tpope/vim-projectionist',         { 'for': clj }
Plug 'tpope/vim-dispatch',              { 'for': clj }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead *.clj try | silent! Require | catch /^Fireplace/ | endtry

" vim:set ft=vim:

