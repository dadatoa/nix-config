{ pkgs
, inputs
, ...
}:
{
  imports =
  [
    ../../modules/00-base.nix
  ];

  # used for backwards compatibility
  system.stateVersion = 5;

  system.primaryUser = "dadatoa";

  # fingerprint for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs.hostPlatform = "aarch64-darwin";

  # services.tailscale.enable = true;
  # intall with tailscale standalone version

  environment.systemPackages = with pkgs; [
    ansible
    bat
    carapace # shell auto-completion
    coreutils
    eza
    ext4fuse
    fd
    fish
    flyctl
    fzf
    gh
    glab
    lazygit
    lima
    ### LSP
    lua-language-server    
    ###
    mosh
    nmap
    nodejs
    nushell
    opentofu
    podman
    rclone
    ripgrep
    rsync
    sesh
    starship
    stow
    tmux
    wezterm
    zoxide
    ## charm
    gum
    wishlist
  ];
}
