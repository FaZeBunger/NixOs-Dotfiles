{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/home.nix
    ../../modules/user/assistant.nix
    ../../modules/user/gaming.nix
  ];

  home.file = {
    ".config/hypr" = {
      source = ../../configs/hypr;
      recursive = true;
    };
    ".config/waybar" = {
      source = ../../configs/waybar;
      recursive = true;
    };
    ".config/rofi" = {
      source = ../../configs/rofi;
      recursive = true;
    };
    ".config/swaync" = {
      source = ../../configs/swaync;
      recursive = true;
    };
  };

  # Install BTOP with gpu support on desktop only
  programs.btop = {
    enable = true;
    settings = {
      proc_gpu_graphs = true;
    };
    package = (pkgs.btop.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/btop --prefix LD_LIBRARY_PATH : /run/opengl-driver/lib
      '';
    }));
  };
}
