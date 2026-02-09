{ config, pkgs, ... }:
{
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    bat
    busybox
    chezmoi # to replce stow for dotfiles
    emacs
    glab
    gh
    gum
    jq
    just
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    nushell
    sesh
    skate # database key-value pair
    starship
    stow # to be replaced by chezmoi
    tmux
    zoxide
  ];
}
