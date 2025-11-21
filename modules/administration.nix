{ config, lib, pkgs, inputs, ... }:
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    busybox
    pciutils
    usbutils
    e2fsprogs # ext2,3,4 filesytem
    parted
    git
    wget
    nmap
    vim
  ];

} 
