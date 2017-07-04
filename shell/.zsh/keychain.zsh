# start keychain
[ -x "$(which keychain)" ] && eval `keychain --quiet --eval id_rsa`
