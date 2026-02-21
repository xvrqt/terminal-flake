{
  #TODO: This needs a nixos version i think... for dealing with shells ?
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Useful CLI programs
    cli.url = "git+https://git.irlqt.net/crow/cli-flake";
    # cli.inputs.nixpkgs.follows = "nixpkgs";
    # Preconfigured NeoVim
    # neovim.url = "github:xvrqt/neovim-flake";
    # Ghostty Terminal Emulator Flake
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs =
    { cli
      # , neovim
    , nixpkgs
    , ghostty
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
      emulators = [ "alacritty" "foot" "ghostty" ];

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
              cli.homeManagerModules.default
              # Extremely customized NeoVim
              # neovim.homeManagerModules.${system}.default
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
