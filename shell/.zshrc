# Lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# start tmux
if [ "$TMUX" = "" ]; then
    tmux attach || tmux
fi

# Base PATH
PATH="$PATH:/usr/local/bin:/usr/local/sbin:/sbin:/usr/sbin:/bin:/usr/bin"

# Conditional PATH additions
for path_candidate in \
    /opt/local/sbin \
    /Applications/Xcode.app/Contents/Developer/usr/bin \
    /opt/local/bin \
    /usr/local/share/npm/bin \
    ~/.cabal/bin \
    ~/.cargo/bin \
    ~/.rbenv/bin \
    ~/.luarocks/bin \
    ~/Library/Python/3.9/bin \
    ~/.local/bin \
    ~/bin \
    ~/lib/bin \
    ~/.emacs.d/bin \
    ~/.nix-profile/bin
do
    if [ -d ${path_candidate} ]; then
        export PATH="${PATH}:${path_candidate}"
    fi
done

# nix
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
    . $HOME/.nix-profile/etc/profile.d/nix.sh
fi

if [[ -f ~/.profile.local ]]; then
    source ~/.profile.local
fi

# After the path we can check if this is a dumb terminal
if [[ "$TERM" == "dumb" ]]; then
    unsetopt zle
    PS1='$ '
    return
fi

if [[ -f ~/.config/zsh/plugins ]]; then
    source ~/.config/zsh/plugins
fi

for i in ~/.config/zsh/rc.d/*.zsh; do
    source $i
done

# Customize to your needs...
# Stuff that works on bash or zsh
if [ -r ~/.config/zsh/aliases ]; then
    source ~/.config/zsh/aliases
fi

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
    source ~/.aws/aws_variables
fi

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
    export JAVA_HOME=/Library/Java/Home
fi
