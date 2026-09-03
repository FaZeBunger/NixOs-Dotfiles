{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.fira-code

    # Standard Package Namespaces
    pkgs.font-awesome
    pkgs.cascadia-code
    pkgs.material-design-icons
    pkgs.mononoki
    pkgs.noto-fonts-cjk-sans
  ];
}
