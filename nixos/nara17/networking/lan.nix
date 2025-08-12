{ config
, lib
, ...
}:
{

  networking.hostName = "nara17";

  networking.firewall.enable = false;
  # networking.interfaces."enp2s0".wakeOnLan.enable = true; # issue when rebuild?

  ## manage network with systemd
  networking.useNetworkd = true;
  systemd.network.enable = true;
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

  ## wireless
  networking.wireless = {
    enable = true;
    secretsFile = "/etc/wpa_supplicant.conf";
    interfaces = [
      "wlp3s0"
    ];
    userControlled.enable = true;
  };
}
