# Enable keychain
if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet --agents ssh,gpg $SSH_AGENT_KEYS $GPG_AGENT_KEYS`

    echo SSH_AUTH_SOCK="$SSH_AUTH_SOCK" > ~/.ssh/.env
    echo SSH_AGENT_PID="$SSH_AGENT_PID" >> ~/.ssh/.env
    echo GPG_AGENT_KEYS="$GPG_AGENT_KEYS" >> ~/.ssh/.env
    echo GPG_AGENT_INFO="$GPG_AGENT_INFO" >> ~/.ssh/.env
fi
