### nrtv17-1 custom services config

{ pkgs, ... }:
{

  networking.wireless = {
    enable = false;
    secretsFile = "/etc/wpa_supplicant.conf";
    interfaces = [
      "wlp3s0"
    ];
    userControlled.enable = true;
  };


  ## custom service to start wifi connection
  systemd.services.mywifi = {
    enable = true;
    description = "custom wpa_supplicant";
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.wpa_supplicant ];
    script = ''
      /run/current-system/sw/bin/ip link set dev wlp3s0 up
      /run/current-system/sw/bin/ifconfig wlp3s0 up
      /run/current-system/sw/bin/wpa_supplicant -c /etc/wpa_supplicant.conf -i wlp3s0   
    '';
  };
}
