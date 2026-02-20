{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      macmini = inputs.stable-nix.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ./macmini
        ];
      };
      xen = inputs.stable-nix.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ./xen
        ];
      };
      nas = inputs.stable-nix.lib.nixosSystem {
        modules = [
          ./vm-nixnas
        ];
      };
    };

    darwinConfigurations.dadabook = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./dadabook
      ];
    };
  };
}
