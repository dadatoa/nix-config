### nrtv17-1 custom services config

{ pkgs, ... }:
{

  networking.wireless = {
    enable = false;
    # secretsFile = "/run/secrets/wireless.conf";
    interfaces = [
      "wlp0s20f0u1"
    ];
    userControlled.enable = true;
  };


  ## custom service to start wifi connection
  systemd.services.wifi = {
    enable = true;
    description = "custom wpa_supplicant";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.wpa_supplicant ];
    script = ''
      wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp3s0   
    '';
  };
}
