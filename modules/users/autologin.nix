{ config, pkgs, lib, ... }:{
  
  # Allow the graphical user to login without password
  users.users.nixos.initialHashedPassword = "";
  # Allow the user to log in as root without a password.
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

  # Some more help text.
  services.getty.helpLine = ''
    The "nixos" and "root" accounts have empty passwords.

    To log in over ssh you must set a password for either "nixos" or "root"
    with `passwd` (prefix with `sudo` for "root"), or add your public key to
    /home/nixos/.ssh/authorized_keys or /root/.ssh/authorized_keys.

    '';

  # allow nix-copy to live system
  nix.settings.trusted-users = [ "nixos" ];
}
