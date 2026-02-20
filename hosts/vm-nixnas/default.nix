{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/profiles/xen_domU.nix
    ./hardware-configuration.nix
  ];

  system.stateVersion = "26.05";

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # bootc
    # podman-bootc
  ];

  networking.hostName = "nas";
  
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "enX0";
    networkConfig.DHCP = "ipv4";
  };

  services.glusterfs.enable = true;
}
