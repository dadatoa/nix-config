{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      # ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.systemd-boot.consoleMode = "0";
  # boot.initrd.kernelModules = [ "wl" ];
  # boot.kernelModules = [ "88x2bu" ]; # "wl"
  # boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

  boot.loader.efi.canTouchEfiVariables = true;
  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.utf8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.utf8";
    LC_IDENTIFICATION = "fr_FR.utf8";
    LC_MEASUREMENT = "fr_FR.utf8";
    LC_MONETARY = "fr_FR.utf8";
    LC_NAME = "fr_FR.utf8";
    LC_NUMERIC = "fr_FR.utf8";
    LC_PAPER = "fr_FR.utf8";
    LC_TELEPHONE = "fr_FR.utf8";
    LC_TIME = "fr_FR.utf8";
  };
  

  # Enable experimental features 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # allow unfree packages 
  nixpkgs.config.allowUnfree = true; # defined in flake

  environment.systemPackages = with pkgs; [
  btrfs-progs
  curl 
  exfat 
  fzf
  git
  hdparm
  neovim
  nmap
  overmind # process manager
  pv # progress bar when copy file
  sesh
  starship
  tailscale
  tmux
  wget
  zoxide
  ];

  # Enable networking config with network manager
  networking.networkmanager.enable = true;

  # start ssh-agent
  programs.ssh.startAgent = true;

  services = {
    # enable autorandr pour autodetect monitors 
    # autorandr.enable = true;
    # Enable ssh
    openssh = {
      enable = true;
      openFirewall = true;
    };


    # Enable Tailscale
    tailscale.enable = true;
    tailscale.openFirewall = true;

    # Avahi for auto discover based on hostname
    avahi = {
      publish = {
        enable = true;
        userServices = true;
      };
      enable = true;
      openFirewall = true;
    };

    udisks2 = {
      enable = true;
      mountOnMedia = true;
      settings = {
        "ata-WDC_WD40PURX-64AKYY0_WD-WX92DA1J6L8Z" = {
          ATA = {
            StandbyTimeout = "240";
          }; 
        };
        "ata-TOSHIBA_DT01ACA050_X8LDNTAKS" = {
          ATA = {
            StandbyTimeout = "240";
          }; 
        };
      };
    };

  };

   

  system.stateVersion = "24.11";
}
