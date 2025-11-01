## Mac mini base config
{ config, lib, pkgs, ... }:
{
imports = [
    ./hardware-configuration.nix
    ../../modules/01-nixos.nix
    ../../modules/administration.nix
    ../../modules/virtualisation/docker.nix

    ./containers.nix
  ];

  ## boot fail on mac mini without these
  boot.kernelParams = [
    "vga=0x317"
    "nomodeset"
  ];

  boot.kernelModules = [ "wl" ];

  ## Allow insecure packages for wifi broadcom on mac mini
  nixpkgs.config.allowInsecurePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "broadcom-sta" # aka “wl”
    ];

  # add some packages that are not present in baseConfig.nix
  environment.systemPackages = with pkgs; [
    starship
  ];

  ## enable cockpit to quick overview of server
  services.cockpit = {
    enable = true;
    openFirewall = true;
    settings = {
      WebService = {
        AllowUnencrypted = "true";
      };
    };
  };

  networking.hostName = "macmini";

  networking.firewall.enable = false;
  networking.useDHCP = false;

  networking.useNetworkd = true;

  ## manage network with systemd
  systemd.network.enable = true;

  systemd.network.wait-online.anyInterface = true; 

  systemd.network = {
    ## declare vlan
    netdevs = {
      "20-vlan66" = {
        netdevConfig = {
          Kind = "vlan";
          Name = "vlan66";
          Description = "LAN Access";
        };
        vlanConfig = {
          Id = 66;
        };
      };
    };
    ## network interfaces
    networks = {
      "30-lan" = {
        enable = true;
        matchConfig.Name = "enp2s0f0";
        # networkConfig.DHCP = "ipv4";
        ## add vlans on physical interface
        vlan = [
          "vlan66"
        ];
      };
      ## add virtual interfaces for vlan
      "50-vlan66" = {
        matchConfig.Name = "vlan66";
        networkConfig.DHCP = "ipv4";
      };
    };
  };

  users = {
    users.dadato = {
      isNormalUser = true;
      uid = 1000;
      description = "individual user - services manager";
      extraGroups = [
        "docker" "wheel"
      ];
      # shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook.local"
      ];
      shell = pkgs.nushell;
    };

    users.nixos = {
      # admin user defined to nixos
      isNormalUser = true;
      uid = 1001;
      description = "admin system";
      extraGroups = [
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook.local"
      ];
      # packages = with pkgs; [ ];
    };
  };
  
  security.sudo.wheelNeedsPassword = false;
  
  system.stateVersion = "25.05"; # Did you read the comment?
}
