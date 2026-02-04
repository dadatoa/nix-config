{ config, pkgs, ... }:
{
  users.users.operateur = {
    isNormalUser = true;
    uid = 1000;
    description = "main user";
    extraGroups = [
      "video"
    ];
    # packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO dadatoa@dadabook"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHnWrIExo7hWe04wTUUEn6smnx/LRfNtPtatR+NgQlfz SpaceK@dadabook"
    ];
  };
}
