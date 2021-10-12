# Install deps

	cat dependencies | xargs yaourt -S --needed --noconfirm

# Unstow stuff

	cd .dotfiles && ./poop

*warning*: the script `poop` is a stupid script ... remember that!

### Xresources

Load the extended file:

	#if __has_include(".extend.Xresources")
	#include ".extend.Xresources"
	#endif

# WSL2

Microsoft has no idea ...

```
New-NetFirewallRule -DisplayName "WSL" -Direction Inbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow
```
