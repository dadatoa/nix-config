{ config, pkgs, ... }:{
  imports = [
    ../../modules/xen-vm
    ../../modules/users.nix
  ];
  boot.loader.systemd-boot.enable = true;

  networking.hostName = "xen-vm1";

}
