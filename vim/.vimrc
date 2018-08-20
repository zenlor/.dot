" Neovim configuration

set ttyfast " Faster terminal

set runtimepath^=~/.config/vim runtimepath+=~/.config/vim/after
let &packpath = &runtimepath
source ~/.config/vim/init.vim

" vim:set fdl=0 fdm=marker:
