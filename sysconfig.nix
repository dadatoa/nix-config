{ inputs, ... }:
{
  flake = {
    nixosConfigurations = {
      macmini = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ./hosts/macmini
        ];
      };
      xen = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          inputs.disko.nixosModules.default
          ./hosts/xen
        ];
      };
      xen-vm1 = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/vm
        ];
      };
    };

    darwinConfigurations.dadabook = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./hosts/dadabook
      ];
    };
  };
  ### Generators AKA VMs configs
  packages = {
    bootc-xen-pv = inputs.nixos-generators.nixosGenerate {
      format = "qcow"
      modules = [
        { virtualisation.diskSize = 10 * 1024; } # set size to 10G
        ./hosts/bootc-xen-pv
      ];
    };
  };
}
