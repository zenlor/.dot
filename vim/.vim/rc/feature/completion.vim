Plug 'Valloric/YouCompleteMe'

augroup load_ycm
    autocmd!
    autocmd CursorHold, CursorHoldI * :packadd YouCompleteMe
                \ | autocmd! load_ycm
augroup END
