{ config, pkgs, ... }:

{
  users = {
    users.dadato = {
      isNormalUser = true;
      uid = 1000;
      description = "individual user - services manager";
      extraGroups = [ "networkmanager" "docker" ];
      # shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
      ];
      packages = with pkgs; [];
      };

    users.nixos = { # admin user defined to nixos
      isNormalUser = true;
      uid = 1001;
      description = "admin system";
      extraGroups = [ "wheel" "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
      ];
      packages = with pkgs; [];
      };

    users.natcha = {
     isNormalUser = true;
     uid = 1002;
     description = "individual user";
     # extraGroups = [ "docker" "networkmanager" ];
     packages = with pkgs; [];
     };
    
    };

  # no sudo password for admin user
  # no password is set for this account
  # should only be accessed threw ssh with ssh key
  security.sudo.extraRules = [
  {
    users = [ "nixos" ];
    commands = [ { command = "ALL"; options = [ "NOPASSWD" ]; } ];
  }
  ];

  # autologin user dadato at startup on tty
  # services.getty.autologinUser = "dadato"; 

}
