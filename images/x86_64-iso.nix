{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ../modules/00-base.nix
  ];

  ## platform 
  nixpkgs.hostPlatform = "x86_64-linux";

  # Load drivers for mac intel wifi
  # boot.initrd.kernelModules = [ "wl" ];

  # Load driers for mac intel & tplink archer wifi
  boot.kernelModules = [ "88x2bu" "kvm-intel" "wl" ];



  # bigger image, shorter compilation time
  isoImage.squashfsCompression = "lz4";

}
