{ pkgs
, inputs
, ...
}:
{
  imports =
  [
    ../../modules/settings.nix
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
    carapace
    chezmoi
    coreutils
    cosign
    docker
    ext4fuse ## did not find in brew
    eza
    fd
    flyctl
    fzf
    gh
    glab
    glow
    gum
    just
    lazygit
    neovim
    nmap
    nushell
    opentofu
    podman
    rclone
    ripgrep
    rsync
    sesh
    skate
    starship
    stow
    tldr
    tmux
    tree-sitter
    wishlist
    zoxide
    ### LSP
    lua-language-server    
    ###
  ];
}
