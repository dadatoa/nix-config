{ pkgs, ... }:
{
  imports = [
    ./docker.nix
    ./xen.nix
  ];
}
