{ lib, pkgs, config, ... }:
let
  # Check that the parent module is enabled, and the emulator matches
  cfgCheck = config.terminal.enable && config.terminal.emulator == "ghostty";
in
{
  # Configure and style Ghostty
  home = {
    # Enable Ghostty
    packages = lib.mkIf cfgCheck [ pkgs.ghostty ];
    file = {
      ".config/ghostty/config".source = ./ghostty.conf;
      ".config/ghostty/themes/catppuccin-mocha.conf".source = ./themes/catppuccin-mocha.conf;
    };
  };
}
