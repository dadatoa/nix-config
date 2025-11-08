{ config, lib, pkgs, inputs, ... }:
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.settings.auto-optimise-store = true;

  environment.systemPackages = with pkgs; [
    pciutils
    usbutils
    git
    wget
    nmap
    vim
  ];

} 
