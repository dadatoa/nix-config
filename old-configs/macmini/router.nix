{ config
, lib
, ...
}:
{
  networking.firewall = {
    enable = true;
    extraCommands = ''
      # Set up SNAT on packets going from downstream to the wider internet
      iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE

      # Accept all connections from downstream. May not be necessary
      iptables -A INPUT -i enp2s0f0 -j ACCEPT  
    '';
    allowedTCPPorts = [
      22
      53
      80
      443
      8080
      8443
    ];
    allowedUDPPorts = [
      53
    ];
  };
}
