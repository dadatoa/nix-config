# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configurations/dom01.nix
      ./filesystems/disko-dom01.nix
      ../modules/01-nixos.nix
      ../modules/administration.nix
      ../modules/virtualisation/xen.nix ## Xen config
    ];

  boot.kernelParams = 
  [
    ### xen special boot kernel param
    ### hide pci device wifi from dom0 to be abble to pass it on anther damain
    # "xen-pciback.hide=(03:00.0)"
    "intel_iommu=on"
    ];

  boot.loader.systemd-boot.netbootxyz.enable = true;
  
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

  networking.hostName = "dom01";

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall.enable = false;

  ## manage network with systemd
  networking.useNetworkd = true;
  systemd.network.enable = true;

  systemd.network = {
    ## declare vlan
    netdevs = {
      "20-xenbr0" = {
        netdevConfig = {
          Kind = "bridge";
          Name = "xenbr0";
          Description = "xen default bridge";
        };
      };
      "20-vlan1" = {
        netdevConfig = {
          Kind = "vlan";
          Name = "vlan1";
          Description = "device config Access";
        };
        vlanConfig = {
          Id = 1;
        };
      };
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
        matchConfig.Name = "enp2s0";
        # networkConfig.DHCP = "ipv4";
        ## add vlans on physical interface
        vlan = [ "vlan66" "vlan1" ];
      };

      ## add virtual interfaces for vlan
      "40-vlan66" = {
        matchConfig.Name = "vlan66";
        networkConfig.DHCP = "ipv4";
        networkConfig.Bridge = "xenbr0"; ## attach to bridge
      };
      ## add virtual interfaces for vlan
      "40-vlan1" = {
        matchConfig.Name = "vlan1";
        networkConfig.DHCP = "ipv4";
        address = [
        ];
      };
      ## add bridge interface for vlans
      "40-xenbr0" = {
        matchConfig.Name = "xenbr0";
        networkConfig.DHCP = "ipv4";
        linkConfig = {
          RequiredForOnline = "carrier";
        };
      };
    };
  };

  # DO NOT TOUCH
  system.stateVersion = "25.05"; # Did you read the comment?
}

