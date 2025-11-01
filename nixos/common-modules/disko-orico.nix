{
  disko.devices = {
    disk = {
    orico1 = {
      type = "disk";
      device = "/dev/disk/by-id/ata-TOSHIBA_DT01ACA050_X8LDNTAKS";
      content = {
        type = "gpt";
        partitions = {
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
            };
          };  
        };
      };
    };
    
    orico2 = {
      type = "disk";
      device = "/dev/disk/by-id/ata-WDC_WD40PURX-64AKYY0_WD-WX92DA1J6L8Z";
      content = {
        type = "gpt";
        partitions = {
          root = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
            };
          };  
        };
      };
    };
    };
  };
}
