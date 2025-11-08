{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      macmini = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ../hosts/macmini/default.nix
        ];
      };
      xen = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ../hosts/xen
        ];
      };
    };

    darwinConfigurations.dadabook = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ../hosts/dadabook
      ];
    };
  };
}
