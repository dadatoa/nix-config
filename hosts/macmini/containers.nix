{ pkgs, config, lib, ... }:

{
  virtualisation.oci-containers.containers = {
    netbootxyz = {
      volumes = [
        "/appdata/netbootxyz/config:/config"
        "/appdata/netbootxyz/assets:/assets"
        ];
      environment = {};
      ports = [
        "3000:3000"
        "69:69/udp"
        "8080:80"
      ];
      image = "ghcr.io/netbootxyz/netbootxyz" ;
    };
  };
}
