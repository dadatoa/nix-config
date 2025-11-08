{ config, pkgs, lib, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/virtualisation/xen-domU.nix")
    ../00-base.nix
    ../users
    ../users/autologin.nix
  ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
