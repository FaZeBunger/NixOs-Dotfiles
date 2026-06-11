{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/home.nix
    ../../modules/user/assistant.nix
    ../../modules/user/gaming.nix
    ../../modules/user/unity.nix
  ];

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
