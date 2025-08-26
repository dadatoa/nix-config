{ ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./users.nix
    ./storage.nix
    ./networking
  ];
}
