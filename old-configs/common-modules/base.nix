{ pkgs, inputs, ... }:
{
  time.timezone = "Asia/Bangkok";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flake"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    inputs.nixvim.packages.${system}.default # # nixvim -> custom nix neovim configuration
    ansible
    bat
    # btrfs-progs
    curl
    # exfat
    fish
    fzf
    gh
    git
    glab
    # hdparm
    # kea # adding package allow access to kea libs in /run/current-system
    lazygit
    nmap
    # overmind # process manager
    python3Minimal
    pv # progress bar when copy file
    sesh
    starship
    tailscale
    tmux
    wezterm # allow wezterm connect from my other machines with wezterm
    wget
    zoxide
  ];

  services = {
    # enable autorandr pour autodetect monitors
    # autorandr.enable = true;
    # Enable ssh
    openssh = {
      enable = true;
      openFirewall = true;
    };

    # Enable Tailscale
    tailscale.enable = true;
    tailscale.openFirewall = true;
  };

}
