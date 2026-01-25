{ pkgs, config, lib, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
  
# docker rootless
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
# enable lingering for operateur to le rootless container running
  users.users.operateur.linger = true;

  virtualisation.oci-containers.containers = {
  };
}
