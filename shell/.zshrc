# Lang
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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

if [[ -f ~/.config/zsh/plugins ]]; then
    source ~/.config/zsh/plugins
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

# Yes, these are a pain to customize. Fortunately, Geoff Greer made an online
# tool that makes it easy to customize your color scheme and keep them in sync
# across Linux and OS X/*BSD at http://geoff.greer.fm/lscolors/
export CLICOLOR=1
export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'

if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh,gpg $SSH_AGENT_KEYS $GPG_AGENT_KEYS`

    cat <<EOF > ~/.ssh/.env
SSH_AUTH_SOCK=$SSH_AUTH_SOCK
SSH_AGENT_PID=$SSH_AGENT_PID
GPG_AGENT_KEYS=$GPG_AGENT_KEYS
GPG_AGENT_INFO=$GPG_AGENT_INFO
EOF
fi

# Customize to your needs...
# Stuff that works on bash or zsh
if [ -r ~/.sh_aliases ]; then
    source ~/.sh_aliases
fi

# Load AWS credentials
if [ -f ~/.aws/aws_variables ]; then
    source ~/.aws/aws_variables
fi

# JAVA setup - needed for iam-* tools
if [ -d /Library/Java/Home ];then
    export JAVA_HOME=/Library/Java/Home
fi
