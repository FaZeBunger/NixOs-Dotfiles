{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeManager.default
  ];

  programs.noctalia.settings = {
    # Bar layout
    bar.default = {
        start = ["workspaces" "active_window" "media" ];   # left side
        end   = ["volume" "battery" "bluetooth" "network" "clock" "tray" "notifications" ];  # right side
        thickness = 36;          # bar height in pixels
        margin_ends = 1.0;       # horizontal margin (0 = full width)
        padding = 4;             # internal padding
        capsule = true;         # pill/floating bar style
    };

    # Workspaces widget options
    # (configured via the widget in the bar, not separately)
  };
}
