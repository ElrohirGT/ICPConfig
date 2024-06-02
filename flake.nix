{
  description = "The lord of the Code's Vim configuration for ICPC Challenge";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixVim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixVim,
  }: let
    forAllSystems = {
      pkgs ? nixpkgs,
      function,
    }:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-macos"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system:
        function {
          inherit system;
          pkgs = import pkgs {
            config.allowUnfree = true;
            # overlays = [];
          };
        });
    buildVimModule = {
      system,
      module,
    }: let
      nixvimPkgs = nixVim.legacyPackages.${system};
      nixVimModule = {
        module = import "${module}";
      };
    in
      nixvimPkgs.makeNixvimWithModule nixVimModule;
  in {
    devShells = forAllSystems {
      function = {
        pkgs,
        system,
      }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            jdk
          ];
        };
      };
    };

    packages = forAllSystems {
      function = {
        pkgs,
        system,
      }: {
        default = buildVimModule {
          inherit system;
          module = ./full.nix;
        };
      };
    };
  };
}
