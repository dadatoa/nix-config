{ pkgs
, inputs
, ...
}:
{
  imports =
  [
    ../../modules/settings.nix
    ../../modules/usefull_tools.nix
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
    ext4fuse ## did not find in brew
    neovim
    starship
    ### LSP
    lua-language-server    
    ###
  ];
}
