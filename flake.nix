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
      # New Config Options
      options = import ./options.nix {inherit lib;};
      # Which terminals are available to enable
      emulators = ["alacritty" "foot"];
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
            # (import ./options.nix {inherit lib;})
            options
            # Terminal Emulator Configurations
            (import ./homeManagerModule.nix {inherit lib emulators;})
          ];
        };
        # I want it all (by default)
        default = homeManagerModules.maximal;
      };
    });
}
