{ config, lib, ... }:
{
  ## dhcp kea
  services.kea.dhcp4 = {
    enable = true;

    settings.interfaces-config = {
      interfaces = [
        # "enp2s0f0/10.120.17.241"
        "vlan1"
        "vlan100"
        "vlan66"
      ];
    };

    settings.lease-database = {
      name = "/var/lib/kea/dhcp4.leases";
      persist = true;
      type = "memfile";
    };

    settings.rebind-timer = 2000;
    settings.renew-timer = 1000;

    settings.subnet4 = [
      {
        id = 1;
        pools = [{ pool = "192.168.8.11 - 192.168.8.19"; }];
        subnet = "192.168.8.0/24";
        interface = "vlan1";
        option-data = [
          {
            name = "routers";
            data = "192.168.8.1";
          }
          {
            name = "domain-name-servers";
            data = "192.168.8.1";
          }
        ];
      }
      {
        id = 2;
        pools = [{ pool = "192.168.8.21 - 192.168.8.29"; }];
        subnet = "192.168.8.0/24";
        interface = "vlan66";
        option-data = [
          {
            name = "routers";
            data = "192.168.8.1";
          }
          {
            name = "domain-name-servers";
            data = "192.168.8.1";
          }
        ];
      }
      {
        id = 3;
        pools = [{ pool = "192.168.8.31 - 192.168.8.39"; }];
        subnet = "192.168.8.0/24";
        interface = "vlan100";
        option-data = [
          {
            name = "routers";
            data = "192.168.8.1";
          }
          {
            name = "domain-name-servers";
            data = "192.168.8.1";
          }
        ];
      }
    ];
  };
}
