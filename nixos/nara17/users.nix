## nixos/nara17/users

{ pkgs, ... }:

{
  users = {
    users.nixos = {
      isNormalUser = true;
      uid = 1000;
      description = "services manager and system admin";
      extraGroups = [
        "wheel"
      ];
      # packages = with pkgs; [ ];
      openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO dadatoa@dadabook"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook"
      ];
   };
    };

  # no sudo password for admin users difined by belonging to wheel group
  # no password is set for these accounts
  # should only be accessed threw ssh with ssh key

  security.sudo.wheelNeedsPassword = false;

}
