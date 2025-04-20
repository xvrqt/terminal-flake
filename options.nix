{ lib
, emulators
, ...
}:
let
  ###################
  ## SETUP OPTIONS ##
  ###################
  # Which CLI programs to install
  # You can also enable program collections by using the `cli.<program>.enable`
  # Ref: https://github.com/xvrqt/cli-flake
  programs = [ "system" "media" "productivity" ];
  # Which shell to use with the terminal
  # You can enable additional shells by using `programs.<shell>.enable`
  # You can enable their additional configuration by setting `programs.<shell>.crowConfig`
  # Ref: https://github.com/xvrqt/cli-flake
  shells = [ "zsh" "bash" "fish" "nushell" ];

  options = {
    terminal = {
      # Whether or not to apply the settings in this module
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };

      # Which terminal emulator to install (must be one of `terminals[]`)
      emulator = lib.mkOption {
        type = lib.types.enum emulators;
        default = "alacritty";
      };

      # Which shell to use in the terminal emulator
      shell = lib.mkOption {
        type = lib.types.enum shells;
        default = "zsh";
      };

      # Which CLI/TUI tools to install
      programs = lib.mkOption {
        type = lib.types.listOf lib.types.enum programs;
        default = "all";
      };
    };
  };
in
{
  inherit options;
}
