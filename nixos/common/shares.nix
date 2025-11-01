{ ... }:
{
  services.samba.settings = {
    global = {
      "guest account" = "nobody";
      "workgroup" = "WORKGROUP";
      "server string" = "smbnix";
      "netbios name" = "smbnix";
    };
  };
}
