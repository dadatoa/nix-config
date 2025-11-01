{ config, lib, pkgs, ... }:
{
  virtualisation = {
    docker.enable = true;
    docker.storageDriver = "btrfs";
  };

  # users.users.dadato.extraGroups = [ "docker" ];
}
