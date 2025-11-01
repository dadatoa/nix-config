orb-prep target:
  cat /etc/nixos/configuration.nix > nixos/{{target}}/configuration.nix
  cat /etc/nixos/orbstack.nix > nixos/{{target}}/orbstack.nix
  cat /etc/nixos/incus.nix > nixos/{{target}}/incus.nix

upgrade target:
  sudo nixos-rebuild switch --flake .#{{target}}

orb target: (orb-prep target) (upgrade target)

test target:
  sudo nixos-rebuild test --flake .#{{target}} && sudo shutdown -r +10
