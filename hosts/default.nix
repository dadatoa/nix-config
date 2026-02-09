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
      nixtest = inputs.stable-nix.lib.nixosSystem {
        modules = [
          ./vm-nixtest
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
