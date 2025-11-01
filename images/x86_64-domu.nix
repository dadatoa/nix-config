{config, lib, pkgs, ... }:
{
  imports = [ ../modules/00-base.nix];
  system.stateVersion = "25.11"; # Did you read the comment?
  boot.initrd.availableKernelModules = [ "ata_piix" "sr_mod" "xen_blkfront" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  nixpkgs.hostPlatform = "x86_64-linux";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.consoleMode = "0";
  boot.loader.efi.canTouchEfiVariables = true;
  
  ## use latest kernel available 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

  nix.settings.auto-optimise-store = true;

  users.users.chef =
  {
      isNormalUser = true;
      uid = 1000;
      description = "system admin";
      extraGroups = [
        "wheel"
      ];
      # packages = with pkgs; [ ];
      openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO dadatoa@dadabook"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook"
      ];
   };

  security.sudo.wheelNeedsPassword = false;

  networking.hostName = "domU1";

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall.enable = false;

  # start ssh-agent
  programs.ssh.startAgent = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

}
