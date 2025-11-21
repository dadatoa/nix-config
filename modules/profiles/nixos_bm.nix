{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ../settings.nix
    ../administration.nix
    ../localisation.nix
    ../remote_access.nix
    ../usefull_tools.nix
    ../users/default_user.nix
  ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.consoleMode = "0";
  boot.loader.efi.canTouchEfiVariables = true;
  ## use latest kernel available 
  boot.kernelPackages = pkgs.linuxPackages_latest;

  ## enable wifi with wpa_supplicant
  networking.wireless.enable = true;
}
