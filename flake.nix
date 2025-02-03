{
  #TODO: This needs a nixos version i think... for dealing with shells ?
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Useful CLI programs
    cli.url = "github:xvrqt/cli-flake";
    # Preconfigured NeoVim
    neovim.url = "github:xvrqt/neovim-flake";
  };

  outputs =
    { cli
    , neovim
    , nixpkgs
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      # NixPkgs Setup
      lib = pkgs.lib;
      pkgs = import nixpkgs { inherit system; };

      # Submodules used in outputs
      # Fonts to include for proper rendering of some features
      fonts = import ./fonts.nix { inherit pkgs; };
      # New Config Options
      options = import ./options.nix { inherit lib emulators; };
      # Submodules required in all outputs, collated
      required = [ options fonts ];

      # Configuration Parameters
      # Which terminals are available to enable
      emulators = [ "alacritty" "foot" ];

      # Enable the config of other sub-flakes (CLI & NeoVim)
      configure_shell = { config, ... }: {
        # Enable the specified shell in `programs`
        programs.${config.terminal.shell}.enable = lib.mkDefault true;
        # TODO: configure the user default shell and pkgs
      };
    in
    rec {
      homeManagerModules = {
        maximal = {
          imports =
            [
              # CLI Programs, Shell Configurations, Starship, ...
              cli.homeManagerModules.${system}.default
              # Extremely customized NeoVim
              neovim.homeManagerModules.${system}.default
              # Terminal Emulator Configurations
              (import ./homeManagerModule.nix { inherit lib emulators; })
              # Configure the sub-flakes based on terminal options
              configure_shell
            ]
            ++ required;
        };
        # I want it all (by default)
        default = homeManagerModules.maximal;
      };
    });
}
