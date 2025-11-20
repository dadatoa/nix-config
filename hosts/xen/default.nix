# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./disko.nix
      ../../modules/profiles/nixos_bm.nix
      ../../modules/virtualisation ## Xen config
    ];

  # DO NOT TOUCH
  system.stateVersion = "25.05"; # Did you read the comment?
  
  boot.kernelParams = 
  [
    ### xen special boot kernel param
    ### hide pci device wifi from dom0 to be abble to pass it on anther damain
    # "xen-pciback.hide=(03:00.0)"
    "intel_iommu=on"
    ];

  boot.loader.systemd-boot.netbootxyz.enable = true;

  security.sudo.wheelNeedsPassword = false;
  
  networking.hostName = "xen";
  
  networking.firewall.enable = false;
  ## manage network with systemd
  networking.useNetworkd = true;
  systemd.network.enable = true;
  systemd.network = {
    netdevs = {  ## declare virtual devices
      "20-xenbr0" = { # bridge
        netdevConfig = {
          Kind = "bridge";
          Name = "xenbr0";
          Description = "xen default bridge";
        };
      };
      "20-vlan66" = { # vlan
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
    networks = { ## network interfaces configurations
      "30-lan" = {
        enable = true;
        matchConfig.Name = "enp2s0";
        # networkConfig.DHCP = "ipv4";
        ## add vlans on physical interface
        vlan = [ "vlan66" "vlan1" ]; # keep both vlan in case 
      };
      ## vlan 66 + xen bridge config
      "40-vlan66" = {
        matchConfig.Name = "vlan66";
        networkConfig.DHCP = "ipv4";
        networkConfig.Bridge = "xenbr0"; ## attach to bridge
      };
      "40-xenbr0" = {
        matchConfig.Name = "xenbr0";
        networkConfig.DHCP = "ipv4";
        linkConfig = {
          RequiredForOnline = "carrier";
        };
      };
    };
  };
}

