{ ... }:
{
  services.adguardhome = {
    enable = true;
    openFirewall = true;
    settings = {
      dns = {
        upstream_dns = [
          # Example config with quad9
          "9.9.9.9"
          "149.112.112.112"
          # Uncomment the following to use a local DNS service (e.g. Unbound)
          # Additionally replace the address & port as needed
          # "127.0.0.1:5335"
        ];
        bind_host = [
          "0.0.0.0"
        ];
      };
      filtering = {
        protection_enabled = true;
        filtering_enabled = true;

        parental_enabled = false; # Parental control-based DNS requests filtering.
        safe_search = {
          enabled = false; # Enforcing "Safe search" option for search engines, when possible.
        };
      };
    };
  };
}
