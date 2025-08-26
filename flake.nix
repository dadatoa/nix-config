{
  description = "my nix configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    { nixpkgs
    , nix-darwin
    , ...
    }@inputs:
    let

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "aarch64-darwin"
        ]
          (system: function nixpkgs.legacyPackages.${system});

    in
    {
      nixosConfigurations = {
        ## Iso configs
        aarch64virtIso = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./customIso/aarch64virt.nix
          ];
        };
        ## virtual machines
        orbnix-1 = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./nixos/orbnix-1
          ];
        };

        ## physical machines
        nara17 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.disko.nixosModules.default
            (import ./nixos/nara17/disko.nix { device = "/dev/nvme0n1"; })
            ./nixos/nara17/configuration.nix
          ];
        };

        macmini = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.disko.nixosModules.default
            (import ./nixos/macmini/disko.nix { device = "/dev/sdb"; })
            ./nixos/macmini
          ];
        };

      };

      ## darwin
      darwinConfigurations = {
        dadabook = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            ./darwin/dadabook.nix
          ];
        };
      };

      ## dev shells
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.glab
            pkgs.gh
            pkgs.git-graph
            pkgs.just
            pkgs.zoxide
            pkgs.starship
            pkgs.fzf
            pkgs.lazygit
          ];
	shellHook = ''
	eval "$(starship init bash)"
	'';
        };
      });
    };

}
