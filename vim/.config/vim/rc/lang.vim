" Language configuration

" Clojure & Lisp & Scheme {{{
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

    " vim-cljfmt
    let g:clj_fmt_autosave = 0
    autocmd vimrc BufWritePre *.clj call cljfmt#AutoFormat()
    autocmd vimrc BufWritePre *.cljc call cljfmt#AutoFormat()

" }}}



" vim:set fdl=0 fdm=marker:
