{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      macmini = inputs.staging-nix.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ../hosts/macmini
        ];
      };
      xen = inputs.staging-nix.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ../hosts/xen
        ];
      };
      vm-nas = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ../hosts/vm-nixnas
          ../hosts/vm-nixnas/hardware-configuration.nix
        ];
      };
    };

    darwinConfigurations.dadabook = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ../hosts/dadabook
      ];
    };
  };
  ### Generators AKA VMs configs

}
