{ config, pkgs, ... }:
{
  ## printing
  services.printing = {
    enable = true;
    drivers = with pkgs; [ canon-capt ];
    allowFrom = [ "all" ];
    listenAddresses = [ "*:631" ];
    browsing = true;
    defaultShared = true;
    openFirewall = true;
  };
}
