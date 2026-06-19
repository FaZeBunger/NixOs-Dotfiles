{ config, lib, pkgs, antigravity, ... }:

{
  # 2. Install the IDE via the native Home Manager module
  # (This gives you a declarative config similar to VSCode)
  programs.antigravity = {
    enable = true;
    # Tell Home Manager to use the exact version from your flake
    package = antigravity.packages.${pkgs.system}.google-antigravity-ide;
  };

  # 3. Install the Base App and CLI as standard packages
  home.packages = [
    antigravity.packages.${pkgs.system}.default  # Antigravity 2.0 Base App
    # antigravity.packages.${pkgs.system}.agy      # The 'agy' CLI tool DISABLED
  ];

}
