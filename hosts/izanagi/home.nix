{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/home.nix
    ../../modules/user/niri.nix
    ../../modules/user/noctalia.nix
  ];

  programs.btop = {
    enable = true;
    settings = {
      proc_gpu_graphs = true;
    };
  };

  home.packages = with pkgs; [
    steam
  ];
}
