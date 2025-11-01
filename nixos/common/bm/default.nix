{ pkgs, ... }:
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.consoleMode = "0";
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    exfat
    hdparm
    wpa_supplicant
  ];

  # mosh as an alrenative to ssh
  programs.mosh.enable = true;

  # Avahi for auto discover based on hostname
  services = {
    avahi = {
      publish = {
        enable = true;
        userServices = true;
      };
      enable = true;
      openFirewall = true;
      nssmdns4 = true;
    };

    # samba-wsdd for autodiscovery on windows
    samba-wsdd = {
      enable = true;
      openFirewall = true;
    };
  };

}
