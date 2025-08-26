{ ... }:
{
  systemd.network = {
    ## declare vlan
    netdevs = {
      "20-vlan100" = {
        netdevConfig = {
          Kind = "vlan";
          Name = "vlan100";
          Description = "LAN Access";
        };
        vlanConfig = {
          Id = 100;
        };
      };
      "20-vlan66" = {
        netdevConfig = {
          Kind = "vlan";
          Name = "vlan66";
          Description = "VLAN for testing purposes";
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
        networkConfig.DHCP = "ipv4";
        # address = [
        #   "10.120.17.248/28"
        # ];
        ## add vlans on physical interface
        vlan = [
          "vlan100"
          "vlan66"
        ];
      };
      ## add virtual interfaces for vlan
      "50-vlan100" = {
        matchConfig.Name = "vlan100";
        networkConfig.DHCP = "ipv4";
        # address = [
        #   "10.120.17.96/26"
        #   # "fd42:23:42:b865::1/64"
        #   # "fe80::1/64"
        # ];
      };
      "50-vlan66" = {
        matchConfig.Name = "vlan66";
        # networkConfig.DHCP = "ipv4";
        address = [
          "10.66.66.1/24"
          # "fd42:23:42:b865::1/64"
          # "fe80::1/64"
        ];
      };
    };
  };

}
