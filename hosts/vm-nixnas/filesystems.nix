{ config, lib, pkgs, ... }:
{
  fileSystems."/data/media" = {
    device = "/dev/xvdb";
    fsType = "btrfs";
    options = [ "subvol=media" "compress=zstd" "noatime" ];
  };
  fileSystems."/data/appdata" = {
    device = "/dev/xvdb";
    fsType = "btrfs";
    options = [ "subvol=appdata" "compress=zstd" "noatime" ];
  };
  fileSystems."/data/share" = {
    device = "/dev/xvdb";
    fsType = "btrfs";
    options = [ "subvol=share" "compress=zstd" "noatime" ];
  };
}
