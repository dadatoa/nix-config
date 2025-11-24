{ config, lib, pkgs, inputs, ... }:
{
  boot.supportedFilesystems.btrfs = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    busybox
    e2fsprogs # ext2,3,4 filesytem
    git
    nmap
    parted
    pciutils
    usbutils
    vim
    wget
  ];

} 
