{ config, pkgs, modulesPath, ... }:{
  imports = [
  ];
  system.stateVersion = "25.11";

  networking.hostName = "xen-vm1";
  
  boot = {
    growPartition = true;
    kernelParams = ["console=ttyS0"];
    loader.grub.enable = true;
    initrd.systemd.enable = true;
  };

  users.users.nixos = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK8cVLhjGtC5ObYAMwXzp/QMag/wbuCJ3BHAns/Ei9DO lab"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMGIPqzuoT/YXmjbgGP6knc1KMzEG0q9D0OjFbv5AOA anonymous@dadabook.local"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHRaK7sawO9SzB/02t68UbQBpTbG28VZ2icniY3Y2hI+ chef@dom01"
    ];
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    # Allow the graphical user to login without password
    initialHashedPassword = "";
  };

  users.users.root.initialHashedPassword = "";
  # Don't require sudo/root to `reboot` or `poweroff`.
  security.polkit.enable = true;
  # Allow passwordless sudo from nixos user
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };
  # Automatically log in at the virtual consoles.
  services.getty.autologinUser = "nixos";

  services.openssh = {
    enable = mkDefault true;
    settings.PermitRootLogin = mkDefault "yes";
  };
  
  systemd.network.networks."10-lan" = {
    matchConfig.Name = "enX0";
    networkConfig.DHCP = "ipv4";
  };
}
