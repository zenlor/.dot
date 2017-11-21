" ----------------------------------------------------------------------------
" ALE
" ----------------------------------------------------------------------------
" let g:ale_linters = {'java': [], 'yaml': [], 'scala': []}
let g:ale_lint_delay = 1000
nmap ]e <Plug>(ale_next_wrap)
nmap [e <Plug>(ale_previous_wrap)

" brew install candid82/brew/joker
command! Joker call ale#linter#Define('clojure', {
\   'name': 'joker',
\   'executable': 'joker',
\   'command': 'joker --lint %t 2>&1',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\}) | ALEDisable | ALEEnable

