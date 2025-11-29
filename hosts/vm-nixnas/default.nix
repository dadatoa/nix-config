{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/profiles/xen_domU.nix
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
    # bootc
    # podman-bootc
  ];

  networking.hostName = "vm-nas";
  
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "enX0";
    networkConfig.DHCP = "ipv4";
  };

  services.glusterfs.enable = true;
}
