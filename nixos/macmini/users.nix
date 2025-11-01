{ pkgs, ... }:

{
  users = {
    users.dadato = {
      isNormalUser = true;
      uid = 1000;
      description = "individual user - services manager";
      extraGroups = [
        "wheel"
      ];
      # shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
      ];
      # packages = with pkgs; [ ];
      shell = pkgs.nushell;
    };

    users.nixos = {
      # admin user defined to nixos
      isNormalUser = true;
      uid = 1001;
      description = "admin system";
      extraGroups = [
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook.local"
      ];
      # packages = with pkgs; [ ];
    };

    users.natcha = {
      isNormalUser = true;
      uid = 1002;
      description = "individual user";
      # extraGroups = [ "docker" "networkmanager" ];
      # packages = with pkgs; [ ];
    };

  };

  # no sudo password for admin users difined by belonging to wheel group
  # no password is set for these accounts
  # should only be accessed threw ssh with ssh key

  security.sudo.wheelNeedsPassword = false;

}
