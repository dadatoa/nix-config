{ config, pkgs, ... }:
{
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    bat
    just
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    skate # database key-value pair
    starship
    stow
    tmux
  ];
}
