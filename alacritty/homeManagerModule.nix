{config, ...}: let
  # Check that the parent module is enabled, and the emulator matches
  cfgCheck = config.terminal.enable && config.terminal.emulator == "alacritty";
in {
  # Enable alacritty
  programs.alacritty = {
    enable = cfgCheck;
    settings = {
      general.import = ["/home/amy/.config/alacritty/theme.toml"];
    };
  };

  # Configure and style Alacritty
  home = {
    file = {
      ".config/alacritty/theme.yml".source = ./themes/catppuccin-mocha.yml;
    };
  };
}
