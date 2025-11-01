{ config, lib, ... }:
{
  ## dhcp kea
  services.kea.dhcp4 = {
    enable = true;

    settings.interfaces-config = {
      interfaces = [
        "enp2s0f0/10.120.17.241"
        "vlan100/10.120.17.65"
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
        pools = [{ pool = "10.120.17.242 - 10.120.17.247"; }];
        subnet = "10.120.17.240/28";
        interface = "enp2s0f0";
        reservations = [
          {
            # easy smart managed router
            hw-address = "DC:62:79:B1:FD:DD";
            ip-address = "10.120.17.254";
          }
          # {
          #   hw-address = "C8:D9:D2:0B:D8:52";
          #   ip-address = "10.120.17.242";
          # }
        ];

        option-data = [
          {
            name = "routers";
            data = "10.120.17.241";
          }
          {
            name = "domain-name-servers";
            data = "10.120.17.241";
          }
        ];
      }
      {
        id = 2;
        pools = [{ pool = "10.120.17.66 - 10.120.17.95"; }];
        subnet = "10.120.17.64/26";
        interface = "vlan100";
        option-data = [
          {
            name = "routers";
            data = "10.120.17.65";
          }
          {
            name = "domain-name-servers";
            data = "10.120.17.65";
          }
        ];
      }
    ];
  };
}
