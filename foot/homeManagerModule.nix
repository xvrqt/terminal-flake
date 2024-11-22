{
  pkgs,
  config,
  ...
}: let
  # Check that the parent module is enabled, and the emulator matches
  cfgCheck = config.terminal.enable && config.terminal.emulator == "foot";
  # Fetch themes from GitHub
  catppuccinMochaTheme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
in {
  # Enable foot
  programs.foot = {
    enable = cfgCheck;
    settings = {
      main = {
        include = "${catppuccinMochaTheme}";
      };
    };
  };
}
