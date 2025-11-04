{ ... }:
{
  networking.hostName = "nara17";

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
  networking.firewall.enable = false;
  # networking.interfaces."enp2s0".wakeOnLan.enable = true; # issue when rebuild?

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
        # linkConfig.RequiredForOnline = "enslaved"; ## 
        # address = [
          # "10.66.66.1/24"
          # "fd42:23:42:b865::1/64"
          # "fe80::1/64"
        # ];
      };
      ## add virtual interfaces for vlan
      "40-vlan1" = {
        matchConfig.Name = "vlan1";
        networkConfig.DHCP = "ipv4";
        address = [
          # "10.66.66.1/24"
          # "fd42:23:42:b865::1/64"
          # "fe80::1/64"
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
}
