{ config, pkgs, lib, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/virtualisation/xen-domU.nix")
    ../settings.nix
    ../users
    ../users/autologin.nix
    ../localisation.nix
    ../administration.nix
  ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  boot.initrd.systemd.enable = true;
  # disble network manager
  networking.networkmanager.enable = false;
  #enable networkd
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "enX0";
    networkConfig.DHCP = "ipv4";
  };
}
