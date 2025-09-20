{ pkgs
, inputs
, ...
}:
{

  # services.nix-daemon.enabled = true;
  nix.settings.experimental-features = "nix-command flakes";
  # enable systemd
  # used for backwards compatibility
  system.stateVersion = 5;

  system.primaryUser = "dadatoa";

  # fingerprint for sudo
  security.pam.services.sudo_local.touchIdAuth = true;
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  # services.tailscale.enable = true;
  # intall with tailscale standalone version

  environment.systemPackages = with pkgs; [
    # inputs.nixvim.packages.${system}.default # add neovim classic way with homebrew
    ansible
    bat
    # container -> does not start, dont know why
    eza
    ext4fuse
    fish
    fzf
    gh
    git
    glab
    lazygit
    librewolf
    lima
    mosh
    nushell
    nmap
    nodejs
    podman
    # fastfetch
    # overmind # process manager
    rclone
    ripgrep # for live grep with telescope in nvim
    rsync
    sesh
    starship
    stow
    telescope
    tmux
    wezterm
    zoxide
    ## charm
    gum
    skate
    wishlist
  ];

  ## enable homebrew package manager
  ## does not install homebrew, have to install with standard procedure on mac os
  homebrew = {
    enable = true;
    taps = [
      "slp/krun"
    ];
    casks = [
      "ghostty"
      "karabiner-elements"
      "leader-key"
      # "ollama-app"
      # "orbstack"
      "stats"
      "tuta-mail"
    ];
    brews = [
      "git-graph" ## broken in nixpkgs
      "neovim"
      "llama.cpp"
      ## microvm
      "buildah" 
      "libkrunfw" 
      "libkrun" 
      "krunvm"
    ];
  };
}
