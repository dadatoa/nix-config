{
  description = "my nix & nixos configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable-nix.url = "github:NixOS/nixpkgs/nixos-25.05";
    staging-nix.url = "github:NixOS/nixpkgs/nixos-25.11"; 
    
    disko.url = "github:nix-community/disko";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ nixos-generators, nixpkgs, stable-nix, staging-nix, disko, nix-darwin, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./sysconfig.nix
      ];
      
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      
      perSystem = { config, self', inputs', pkgs, system, ... }: {

        packages = {
          vm-nixnas = nixos-generators.nixosGenerate {
            system = "x86_64-linux";
            format = "qcow";
            modules = [
              { virtualisation.diskSize = 10 * 1024; } # set size to 10G
              ./hosts/vm-nixnas
            ];
          };
          do-droplet = nixos-generators.nixosGenerate {
            system = "x86_64-linux";
            format = "qcow";
            modules = [
              ./hosts/do-droplet
            ];
          };
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ glab just lazygit neovim starship tmux ]; 
        shellHook = ''
            source ~/.bashrc
        '';
        };
      };
    };
}
