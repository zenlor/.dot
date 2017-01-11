# load profile
source "${HOME}/.profile"

if [[ -o interactive ]]
then
    # zmodload zsh/zprof
    source "${HOME}/.zsh/init.zsh"
else
    source "${HOME}/.zsh/noninteractive.zsh"
fi
