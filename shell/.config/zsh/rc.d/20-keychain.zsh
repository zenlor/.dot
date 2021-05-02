

if command -v keychain &> /dev/null; then
    eval `keychain --eval --quiet \
        --agents ssh,gpg \
        id_ecdsa id_frenzart.com id_rsa 42AA4CF527632EE24A9A75FF34AEDF1F8DA5DA1F`

#    eval `keychain --eval --quiet \
#        --agents ssh,gpg \
#        $SSH_AGENT_KEYS $GPG_AGENT_KEYS`

    cat <<EOF >! ~/.ssh/.env
SSH_AUTH_SOCK=$SSH_AUTH_SOCK
SSH_AGENT_PID=$SSH_AGENT_PID
GPG_AGENT_KEYS=$GPG_AGENT_KEYS
GPG_AGENT_INFO=$GPG_AGENT_INFO
EOF
fi

