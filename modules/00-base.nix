{ config, lib, pkgs, inputs, ... }:
{
  nix = {
    optimise.automatic = true;

    settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

  };

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    just
    git
    nmap
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    skate # database key-value pair
    starship
    stow
    tmux
  ];
  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

}
