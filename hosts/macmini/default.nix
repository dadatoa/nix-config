## Mac mini base config
{ config, lib, pkgs, ... }:
{
imports = [
    ./hardware-configuration.nix
    ../../modules/profiles/nixos_bm.nix
    ./networking.nix
    # ./dhcp-kea.nix
    ./disko.nix
    ./firewall.nix
    ./glusterfs.nix
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
  ];

  services.glusterfs.enable = true;
  services.technitium-dns-server.enable = true;
  
  users.users.operateur = {
    isNormalUser = true;
    uid = 1000;
  };
  security.sudo.wheelNeedsPassword = false;
  
  system.stateVersion = "25.05"; # Did you read the comment?
}
