{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btrfs-progs
    ];
  # start ssh-agent
  programs.ssh.startAgent = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # enable Tailscale with config
  services.tailscale = {
    enable = true;
    authKeyFile = "/run/secrets/tailscale_key";
    authKeyParameters.ephemeral = false;
    authKeyParameters.preauthorized = true;
    extraUpFlags = [ "--ssh" "--advertise-tags=tag:testlab" ];
  };

  ## enable mdns autodiscovery
  services.avahi = {
    publish = {
      enable = true;
      userServices = true;
    };
    enable = true;
    openFirewall = true;
    nssmdns4 = true;
  };
}
