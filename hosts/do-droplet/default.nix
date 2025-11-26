{ config, pkgs, lib, modulesPath, ... }:
{
  imports = [
    ../../modules/users/default_user.nix
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  system.stateVersion = "25.11";

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
    };
  };

  users.users.nixos.extraGroups = [ "podman" ];

  environment.systemPackages = with pkgs; [
    # bootc
    # podman-bootc
  ];

  networking.hostName = "do_nix";

  service.cloud-init.enable = true;
  service.cloud-init.btrfs.enable = true;
  service.cloud-init.settings = {
    };
}
