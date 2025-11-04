{ ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    dataDir = "/data/appdata/jelly";
    # cacheDir = "/data/appdata/jelly/cache";
    user = "datato";
    group = "users";
  };
}
