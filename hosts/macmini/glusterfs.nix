{ config, lib, ... }:

{
  fileSystems."/data/appdata" =
    { device = "vm-nas:/appdata-gfs";
      fsType = "fuse.glusterfs";
    };

  fileSystems."/data/media" =
    { device = "vm-nas:/media-gfs";
      fsType = "fuse.glusterfs";
    };

  fileSystems."/data/share" =
    { device = "vm-nas:/share-gfs";
      fsType = "fuse.glusterfs";
    };
}
