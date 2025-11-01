{
  description = "my nix configurations";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable-nix.url = "github:NixOS/nixpkgs/nixos-25.05";
    staging-nix.url = "github:NixOS/nixpkgs/nixos-25.05"; 
    
    disko.url = "github:nix-community/disko";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
    nixpkgs,
    stable-nix,
    staging-nix,
    nix-darwin,
    ... }@inputs:
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
        dom01 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.disko.nixosModules.default
            ./hosts/dom01.nix
          ];
        };

        macmini = stable-nix.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            inputs.disko.nixosModules.default
            (import ./hosts/macmini/disko.nix { device = "/dev/sdb"; })
            ./hosts/macmini
          ];
        };
      };

      darwinConfigurations = {
        dadabook = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/dadabook
          ];
        };
      };

      ## dev shells
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.glab
            pkgs.just
            pkgs.lazygit
            pkgs.neovim
            pkgs.starship
            pkgs.tmux
          ];
          shellHook = ''
          eval "$(starship init bash)"
          '';
        };
      });
    };

}
