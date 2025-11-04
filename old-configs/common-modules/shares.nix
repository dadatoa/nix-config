{ config, pckgs, ... }: 

{  
  services.samba.settings = {
    global = {
      "guest account" = "nobody";
      "workgroup" = "WORKGROUP";
      "server string" = "smbnix";
      "netbios name" = "smbnix";
    };
    # "Papa" = {
      # "path" = "/mnt/share/Papa";
      # "writable" = "yes";
      # "browseable" = "yes";
      # # "guest ok" = "yes";
      # # "read only" = "no";
      # # "create mask" = "0644";
      # # "directory mask" = "0755";
    # };
    # "Natcha" = {
      # "path" = "/mnt/share/Natcha";
      # "writable" = "yes";
      # "browseable" = "yes";
      # # "guest ok" = "yes";
      # # "read only" = "no";
      # # "create mask" = "0644";
    # };
    # "Public" = {
      # "path" = "/mnt/share/public";
      # "writable" = "yes";
      # "browsable" = "yes";
      # "guest ok" = "yes";
      # "read only" = "no";
      # "force user" = "nobody";
      # "force group" = "nogroup";
      # # "create mask" = "666";
    # };
  };
  
  # samba-wsdd for autodiscovery on windows
  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}
