" Neovim configuration

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set ttyfast " Faster terminal

set runtimepath^=~/.config/vim runtimepath+=~/.config/vim/after
let &packpath = &runtimepath
source ~/.config/vim/init.vim

" vim:set fdl=0 fdm=marker:
