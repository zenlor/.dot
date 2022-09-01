# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# home-manager
if [ -f "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  source "${HOME}/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi
