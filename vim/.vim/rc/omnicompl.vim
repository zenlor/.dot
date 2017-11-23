" Omnicomplete + wild settings {{{
    set tags=./tags,./../tags,./../../tags,./../../../tags,tags

    set complete-=i
    set completeopt=menu
    set wildmenu                    " Show menu instead of auto-complete
    set wildmode=list:longest,full  " command <Tab> completion: list
                                    " matches -> longest common -> then
                                    " all.
    set wildignore+=*.swp,*.log,.sass-cache,.codekit-cache,config.codekit
    set wildignore+=*.class,*.o,*.pyc,*.obj,*DS_Store*
" }}}
"

" Denite/Deoplete {{{
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

" }}}
