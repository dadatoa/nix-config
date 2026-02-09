# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

 boot = {
    growPartition = true;
    kernelParams = ["console=ttyS0" "vga=0x317" "nomodeset"];
    loader.grub.enable = true;
    initrd.systemd.enable = true;
  };
  # Grub loader to allow pvh grub usage
  boot.loader.grub.device = "nodev";

  boot.initrd.kernelModules = [
    "xen-blkfront"
    "xen-tpmfront"
    "xen-kbdfront"
    "xen-fbfront"
    "xen-netfront"
    "xen-pcifront"
    "xen-scsifront"
  ];

  nix = {
    optimise.automatic = true;

    settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
  };

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "nixtest"; # Define your hostname.

  networking.networkmanager.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "26.05"; # Did you read the comment?

}

