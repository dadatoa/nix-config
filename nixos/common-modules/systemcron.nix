{ config, lib, modulesPath, pkgs, specialArgs, options, ... }:

{
  systemd.services = {
    sync-movies = {
      path = [ pkgs.rclone ];
      script = ''
        rclone sync /data/media/movies/ onedrive:media/movies
      '';
      serviceConfig.User = "dadato";
      startAt = "Sat 01:00:00";
    };
    sync-series = {
      path = [ pkgs.rclone ];
      script = ''
        rclone sync /data/media/series/ onedrive:media/series
      '';
      serviceConfig.User = "dadato";
      startAt = "Sun 01:00:00";
    };
    sync-smb = {
      path = [ pkgs.rclone ];
      script = ''
        rclone sync /mnt/share onedrive:share
      '';
      serviceConfig.User = "dadato";
      startAt = "daily";
    };
    sync-appdata = {
      path = [ pkgs.rclone ];
      script = ''
        rclone sync /data/appdata onedrive:appdata
      '';
      serviceConfig.User = "dadato";
      startAt = "daily";
    };    
  };
}
