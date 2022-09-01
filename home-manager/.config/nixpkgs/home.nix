{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "$USER";
  home.homeDirectory = "$HOME";
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    ripgrep
    neovim
    exa
  ];
}
