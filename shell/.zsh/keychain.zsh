# start keychain
if [ -x "$(which keychain)" ]; then
  keys="$(find ~/.ssh/ -type f -name 'id_*' ! -name '*.p*')"
  eval `keychain --quiet --eval $keys`
fi
