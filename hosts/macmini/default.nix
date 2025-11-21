## Mac mini base config
{ config, lib, pkgs, ... }:
{
imports = [
    ./hardware-configuration.nix
    ../../modules/profiles/nixos_bm.nix
    ./networking.nix
    ./disko.nix
    ./containers.nix
  ];

  ## boot fail on mac mini without these
  boot.kernelParams = [
    "vga=0x317"
    "nomodeset"
  ];

  boot.kernelModules = [ "wl" ];

  ## Allow insecure packages for wifi broadcom on mac mini
  nixpkgs.config.allowInsecurePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "broadcom-sta" # aka “wl”
    ];

  # add some packages that are not present in baseConfig.nix
  environment.systemPackages = with pkgs; [
    starship
  ];


  users.users.nixos = {
      extraGroups = [ "docker" ];
  };

  
  security.sudo.wheelNeedsPassword = false;
  
  system.stateVersion = "25.05"; # Did you read the comment?
}
