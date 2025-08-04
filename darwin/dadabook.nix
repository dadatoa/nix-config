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

  environment.systemPackages = with pkgs; [
    # inputs.nixvim.packages.${system}.default # add neovim classic way with homebrew
    ansible
    bat
    eza
    ext4fuse
    fish
    fzf
    gh
    git
    glab
    lazygit
    lima
    nushell
    nmap
    nodejs
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
  ];

  ## enable homebrew package manager
  ## does not install homebrew, have to install with standard procedure on mac os
  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "karabiner-elements"
      "leader-key"
      "ollama-app"
      "orbstack"
      "stats"
    ];
    brews = [
      "git-graph" ## broken in nixpkgs
      "neovim"
    ];
  };
}
