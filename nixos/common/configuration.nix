{ pkgs, inputs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  i18n = {
    defaultLocale = "fr_FR.UTF-8";
    extraLocaleSettings = {
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
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    inputs.nixvim.packages.${system}.default # # nixvim -> custom nix neovim configuration
    bat
    curl
    eza
    fish
    fzf
    gh
    git
    git-graph
    glab
    just
    lazygit
    nfs-utils
    nmap
    python3Minimal
    starship
    stow
    tmux
    wezterm
    wget
    zoxide
  ];

  # start ssh-agent
  programs.ssh.startAgent = true;

  # enable tailscale on very host
  services.tailscale.enable = true;
  services.tailscale.openFirewall = true;

}
