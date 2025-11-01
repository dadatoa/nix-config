{ pkgs, ... }:
{
  systemd.services.wifi = {
    enable = true;
    description = "custom wifi connection service with wpa_supplicant";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.wpa_supplicant ];
    script = ''
      wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp3s0
    '';
  };
}
