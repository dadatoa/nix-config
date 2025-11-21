{ config, pkgs, lib, ... }:
{
  imports = [
    ../profiles/xen_domU.nix
  ];

  system.stateVersion = "25.11";

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
    };
  };

  users.users.nixos.extraGroups = [ "podman" ];

  environment.systemPackages = with pkgs; [
    bootc
    podman-bootc
  ];

  networking.hostName = nixos-pvh;
  
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "enX0";
    networkConfig.DHCP = "ipv4";
  };
}
