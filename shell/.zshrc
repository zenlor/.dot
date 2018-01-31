# load profile
source "${HOME}/.profile"

if [[ -o interactive ]]
then
    # zmodload zsh/zprof
    source "${HOME}/.zsh/init.zsh"
else
    source "${HOME}/.zsh/noninteractive.zsh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

echo $'\e[3mProgramming is not about typing, it\'s about thinking.\e[0m - Rich Hickey'
