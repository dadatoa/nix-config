{ config, lib, pkgs, modulesPath, ... }:

fileSystems."/" =
    { device = "/dev/disk/by-uuid/9e0425b5-ee0b-41e9-812f-dccd5fc9904a";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/9e0425b5-ee0b-41e9-812f-dccd5fc9904a";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9F6B-88F7";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/var/lib/docker/btrfs" =
    { device = "/nix/root/var/lib/docker/btrfs";
      fsType = "none";
      options = [ "bind" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/c4589381-69bf-4b5d-83fa-e330a3fc000d"; }
    ];
