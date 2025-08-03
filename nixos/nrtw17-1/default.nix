### nrtv17-1
{ ... }:
{
  imports = [
    ./hw-configuration.nix
    ./configuration.nix

    ../common/bm
    ../common/configuration.nix
    ../common/shares.nix
    ../common/users.nix
    # ../common/homelab
    ./nas
    ./networking
    ./storage
  ];

}
