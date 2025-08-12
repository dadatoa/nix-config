{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  ## platform 
  nixpkgs.hostPlatform = "x86_64-linux";

  # Load drivers for mac intel wifi
  boot.initrd.kernelModules = [ "wl" ];

  # Load driers for mac intel & tplink archer wifi
  boot.kernelModules = [ "88x2bu" "kvm-intel" "wl" ];


  # add some packages to installer
  # environment.systemPackages = with pkgs; [
  #   ansible
  #   git
  # ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable proprietary hardware
  nixpkgs.config.allowUnfree = true;

  ## add password to nixos user so we can login with ssh after boot directly
  users.users.nixos.initialPassword = "nixos";

  # bigger image, shorter compilation time
  isoImage.squashfsCompression = "lz4";

}
