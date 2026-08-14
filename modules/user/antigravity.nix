{ pkgs, antigravity, ... }:

{
  # 2. Install the IDE via the native Home Manager module
  programs.antigravity = {
    enable = true;
    # Tell Home Manager to use the exact version from your flake
    package = antigravity.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-ide;
  };

  # 3. Install the Base App and CLI as standard packages
  home.packages = [
    antigravity.packages.${pkgs.stdenv.hostPlatform.system}.default  # Antigravity 2.0 Base App
    antigravity.packages.${pkgs.stdenv.hostPlatform.system}.google-antigravity-cli      # The 'agy' CLI tool
  ];

}
