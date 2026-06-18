{ config, pkgs, inputs, ... }:
{
  imports = [
    ../common/home.nix
  ];

  programs.btop = {
    enable = true;
    settings = {
      proc_gpu_graphs = true;
    };
  };

  home.packages = with pkgs; [
    steam
    upower
  ];
}
