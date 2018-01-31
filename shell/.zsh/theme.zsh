
THEME="agkozak"
THEME_HOME="$HOME/.zsh/themes/"

source "${THEME_HOME}/${THEME}.zsh"

[ -f "${HOME}/.dir_colors" ] && eval $(dircolors ${HOME}/.dir_colors)
