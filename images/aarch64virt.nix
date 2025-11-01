{ pkgs, modulesPath, ... }: {
  
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "aarch64-linux";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable proprietary hardware
  nixpkgs.config.allowUnfree = true;

  # SSh key for nixos default account
  users.users.nixos.openssh.authorizedKeys.keys = [ 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC71gpsZF1R1jd5MuCIKN94s7+HQ810T+r2euzFP96Rc installer"
  ];

  users.users.nixos.initialPassword = "nixos";

  # bigger image, shorter compilation time
  isoImage.squashfsCompression = "lz4";

}
