{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  fonts.packages = [
    pkgs.nerdfonts
  ];
  home.packages = with pkgs; [
    # nerdfonts

    fira-code
    fira-code-symbols

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji

    maple-mono-SC-NF

    dina-font
    liberation_ttf
    mplus-outline-fonts.githubRelease
  ];
}
