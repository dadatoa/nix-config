{ config, lib, pkgs, ... }:
let 
  vars = import ./vars.nix;
in
{
  networking.hostName = vars.hostName;

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
        matchConfig.Name = vars.interface0;
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
}
