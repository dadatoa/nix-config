{ config, pkgs, ... }:
{
  users.users.nixos = {
    isNormalUser = true;
    uid = 1000;
    description = "main user";
    extraGroups = [
      "wheel"
    ];
    # packages = with pkgs; [ ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO dadatoa@dadabook"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook"
    ];
  };
}
