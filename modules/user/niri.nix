{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.niri.homeManager.niri ];

  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
            xkb.layout = "us";
            repeat-delay = 600;   # ms before repeat starts
            repeat-rate = 25;     # repeats per second
            numlock = false;
            track-layout = "global"; # or "window"
        };
        touchpad = {
            tap = true;
            natural-scroll = true;
            # dwt = true;  # disable while typing
        };
        focus-follows-mouse.enable = false;
      };

      spawn-at-startup = [
        { argv = ["noctalia"]; }
        { argv = ["swaybg" "--image" "/path/to/wallpaper.jpg"]; }
      ];

      switch-events = {
        lid-close.action.spawn = ["systemctl" "suspend"];
      };

      layout = {
        gaps = 8;
        center-focused-column = "never"; # "never", "always", "on-overflow"
        preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
        ];
        default-column-width = { proportion = 0.5; };
        focus-ring = {
            enable = true;
            width = 2;
            active.color = "#7fc8ff";
            inactive.color = "#505050";
        };
        border.enable = false;
      };

      animations.enable = true;

      binds = {
        "Mod+Return".action.spawn = ["kitty"];
        "Mod+Q".action.close-window = [];
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        "Mod+0".action.focus-workspace = 10;

        "Mod+Ctrl+1".action.focus-workspace = 1;
        "Mod+Ctrl+2".action.focus-workspace = 2;
        "Mod+Ctrl+3".action.focus-workspace = 3;
        "Mod+Ctrl+4".action.focus-workspace = 4;
        "Mod+Ctrl+5".action.focus-workspace = 5;
        "Mod+Ctrl+6".action.focus-workspace = 6;
        "Mod+Ctrl+7".action.focus-workspace = 7;
        "Mod+Ctrl+8".action.focus-workspace = 8;
        "Mod+Ctrl+9".action.focus-workspace = 9;
        "Mod+Ctrl+0".action.focus-workspace = 10;

        "Mod+C".action.screenshot = {};

      };

    };
  };
}
