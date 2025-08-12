{ config
, lib
, pkgs
, ...
}: {
  imports = [
    ../common-modules/configuration.nix
    ../common-modules/users.nix
    ../common-modules/virtualisation.nix
    ./storage.nix
    ./networking.nix
    # ./services.nix
    /etc/nixos/hardware-configuration.nix
  ];

  ## enable systemd boot
  boot.loader.systemd-boot.enable = true;

  services.samba.enable = true;
  services.samba.package = pkgs.samba4Full;
  services.samba.openFirewall = true;

  ## enable docker
  virtualisation.docker.enable = true;
}
