{ config, lib, ... }:

{
  fileSystems."/data/appdata" =
    { device = "vm-nas:/appdata-gfs";
      fsType = "glusterfs";
    };

  fileSystems."/data/media" =
    { device = "vm-nas:/media-gfs";
      fsType = "glusterfs";
    };

  fileSystems."/data/share" =
    { device = "vm-nas:/share-gfs";
      fsType = "glusterfs";
    };
}
