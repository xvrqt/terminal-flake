{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.monoid
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.fira-mono
    nerd-fonts.fira-code

    fira-code
    fira-code-symbols

    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # maple-mono.NF-CN
    maple-mono.truetype
    liberation_ttf
    mplus-outline-fonts.githubRelease
  ];
}
