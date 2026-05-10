{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  fonts.packages = [
    pkgs.pkgs.jetbrains-mono
    pkgs.pkgs.fira-code
    pkgs.pkgs.font-awesome
    pkgs.pkgs.cascadia-code
    pkgs.pkgs.jetbrains-mono
    pkgs.pkgs.material-design-icons
    pkgs.pkgs.mononoki
    pkgs.pkgs.noto-fonts-cjk-sans
  ];
}
