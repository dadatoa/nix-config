rebuild target:
  sudo nixos-rebuild switch --flake .#{{target}}

test target:
  sudo nixos-rebuild test --flake .#{{target}} && sudo shutdown -r +10
