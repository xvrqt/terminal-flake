{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Useful CLI programs
    #cli.url = "github:xvrqt/cli-flake";
    cli.url = "/home/xvrqt/Development/cli-flake";
    neovim.url = "github:xvrqt/neovim-flake";
  };

  outputs = {
    cli,
    neovim,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      lib = pkgs.lib;
      pkgs = import nixpkgs {inherit system;};
    in rec {
      homeManagerModules = {
        maximal = {
          imports = [
            # CLI Programs, Shell Configurations, Starship, ...
            cli.homeManagerModules.${system}.default
            # Extremely customized NeoVim
            neovim.homeManagerModules.${system}.default
            # Useful system fonts
            (import ./fonts.nix {inherit pkgs;})
            # Terminal Options
            (import ./options.nix {inherit pkgs lib;})
          ];
        };
      };

      # I want it all (by default)
      default = homeManagerModules.maximal;
    });
}
