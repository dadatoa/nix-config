{ config, pkgs, modulesPath, ... }:{
  imports = [
    ../../modules/profiles/xen_pv.nix
    ./hardware-configuration.nix
    (modulesPath + "/virtualisation/xen-domU.nix")
  ];
  boot.loader.systemd-boot.enable = true;

  system.stateVersion = "25.11";

  networking.hostName = "xen-vm1";

}
