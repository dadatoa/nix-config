### mac mini

{ ... }:
{
  imports = [
    ./configuration.nix
    ./hw-conf.nix

    ../common/configuration.nix
    ../common/dns.nix
    ../common/users.nix
    # ../common-modules/virtualisation.nix
    # ../common-modules/dhcp-kea-global.nix
    ./dhcp-kea.nix
    ./networking.nix
    ./services.nix
  ];
}
