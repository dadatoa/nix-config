{ ... }:
{
  imports = [
    ./lan.nix
    ./wireless.nix
  ];

  networking.hostName = "nara17";

  networking.firewall.enable = false;
  # networking.interfaces."enp2s0".wakeOnLan.enable = true; # issue when rebuild?

  ## manage network with systemd
  networking.useNetworkd = true;
  systemd.network.enable = true;

}
