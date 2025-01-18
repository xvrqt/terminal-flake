{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts

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
