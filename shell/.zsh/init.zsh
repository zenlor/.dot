source $HOME/.zsh/antigen.bundle.zsh

# Gruvbox colors
_GBOX="$HOME/.config/nvim/bundle/vim-gruvbox/gruvbox_256palette.sh"
[ -f "$_GBOX" ] && source $_GBOX

MINIMAL_RPROMPT=no

# Config
source $HOME/.zsh/completion.zsh
source $HOME/.zsh/config.zsh
source $HOME/.zsh/keyboard.zsh
source $HOME/.zsh/history.zsh
source $HOME/.zsh/utils.zsh
source $HOME/.zsh/alias.zsh
source $HOME/.zsh/nvm.zsh
source $HOME/.zsh/keychain.zsh

if [ "$ZSH_THEME" = "delta" ]; then
  source $HOME/.zsh/theme.delta.zsh
else
  source $HOME/.zsh/theme.zsh
fi

# more environment config

[[ -f "$HOME/.config/locale.conf" ]] && source $HOME/.config/locale.conf;
