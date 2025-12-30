{ config, lib, pkgs, ... }:
{
  networking.hostName = "macmini";

  networking.firewall.enable = false;
  networking.useDHCP = false;

  networking.useNetworkd = true;

  ## manage network with systemd
  systemd.network.enable = true;

  systemd.network.wait-online.anyInterface = true; 

  systemd.network = {
    ## logic devices 
    netdevs = {
      "20-vlan1" = {
        netdevConfig = { Kind = "vlan"; Name = "vlan1"; };
        vlanConfig = { Id = 1; };
      };
      "20-vlan66" = {
        netdevConfig = { Kind = "vlan"; Name = "vlan66"; };
        vlanConfig = { Id = 66; };
      };
      "20-vlan100" = {
        netdevConfig = { Kind = "vlan"; Name = "vlan100"; };
        vlanConfig = { Id = 100; };
      };
    };
    ## networks config
    networks = {
      "30-lan" = {
        enable = true;
        matchConfig.Name = "enp2s0f0";
        networkConfig.DHCP = "ipv4";
        ## add vlans on physical interface
        vlan = [ "vlan66" "vlan100" "vlan1" ];
      };
      ## add virtual interfaces for vlan
      "30-vlan1" = { 
        matchConfig.Name = "vlan1";
        # address = [ "10.10.10.1/28" ];
        networkConfig.DHCP = "ipv4";
      };
      "30-vlan66" = { 
        matchConfig.Name = "vlan66";
        # address = [ "10.10.10.66/27" ];
        networkConfig.DHCP = "ipv4";
      };
      "30-vlan100" = { 
        matchConfig.Name = "vlan100";
        # address = [ "10.10.10.100/27" ];
        networkConfig.DHCP = "ipv4";
      };
    };
  };
}
