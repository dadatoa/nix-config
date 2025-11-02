{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      macmini = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ./hosts/macmini/default.nix
        ];
      };
    };
  };
}
