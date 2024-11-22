{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Useful CLI programs
    cli.url = "github:xvrqt/cli-flake";
    #cli.url = "/home/xvrqt/Development/cli-flake";
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
      # Fonts to include for proper rendering of some features
      fonts = import ./fonts.nix {inherit pkgs;};
      # New Config Options
      options = import ./options.nix {inherit lib emulators;};
      # Which terminals are available to enable
      emulators = ["alacritty" "foot"];
      # Required in all modules
      required = [options fonts];
      # Enable the config of other sub-flakes (CLI & NeoVim)
      cfg = {config, ...}: {
        # Enable the shell by default
        programs.${config.terminal.shell}.enable = lib.mkDefault true;
      };
    in rec {
      homeManagerModules = {
        maximal = {
          imports =
            [
              # CLI Programs, Shell Configurations, Starship, ...
              cli.homeManagerModules.${system}.default
              # Extremely customized NeoVim
              neovim.homeManagerModules.${system}.default
              # Terminal Emulator Configurations
              (import ./homeManagerModule.nix {inherit lib emulators;})
              # Configure the sub-flakes based on terminal options
              cfg
            ]
            ++ required;
        };
        # I want it all (by default)
        default = homeManagerModules.maximal;
      };
    });
}
