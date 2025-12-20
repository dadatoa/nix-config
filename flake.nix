{
  description = "my nix & nixos configs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable-nix.url = "github:NixOS/nixpkgs/nixos-25.11";

    disko.url = "github:nix-community/disko";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    flake-parts.url = "github:hercules-ci/flake-parts";

  };

  outputs = inputs@{ nixos-generators, nixpkgs, stable-nix, staging-nix, disko, nix-darwin, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./hosts
      ];
      
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      
      perSystem = { config, self', inputs', pkgs, system, ... }: {

        packages = {
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
