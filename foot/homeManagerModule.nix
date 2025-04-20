{
  pkgs,
  config,
  ...
}: let
  # Check that the parent module is enabled, and the emulator matches
  cfgCheck = config.terminal.enable && config.terminal.emulator == "foot";
  # Get default shell
  shell = config.terminal.shell or "bash";
  # Fetch theme from GitHub
  catppuccinMochaTheme = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/foot/009cd57bd3491c65bb718a269951719f94224eb7/catppuccin-mocha.conf";
    hash = "sha256-plQ6Vge6DDLj7cBID+DRNv4b8ysadU2Lnyeemus9nx8=";
  };
  # Font Config
  font = "JetBrainsMono NF";
  size = "12.5";
  #fontItalic = "Maple Mono SC NF";
in {
  # Enable foot
  programs.foot = {
    enable = cfgCheck;
    # Foot uses a single daemon to supply its clients
    server.enable = cfgCheck;
    # Only in NixOS
    # theme = "catppuccin-mocha";
    settings = {
      main = let
        withSize = "size=${toString size}";
      in {
        inherit shell;
        # Theme
        include = "${catppuccinMochaTheme}";
        login-shell = "yes";
        dpi-aware = "no";

        # Font Rendering
        font = "${font}:${withSize}";
        font-bold = "${font}:style=Bold:${withSize}";
        #font-italic = "${fontItalic}:style=Italic:${withSize}";
        #font-bold-italic = "${fontItalic}:style=BoldItalic:${withSize}";
        box-drawings-uses-font-glyphs = false;
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
