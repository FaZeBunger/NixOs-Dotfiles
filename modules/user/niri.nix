{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.niri.homeModules.niri ];

  xdg.desktopEntries.emacsclient = {
    name = "Emacs (Client)";
    genericName = "Text Editor";
    exec = "emacsclient -c -a \"\"";
    icon = "emacs";
    terminal = false;
    categories = [ "Development" "TextEditor" ];
  };

  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
            xkb.layout = "us";
            repeat-delay = 600;
            repeat-rate = 25;
            numlock = false;
            track-layout = "global";
        };
        touchpad = {
            tap = true;
            natural-scroll = true;
        };
        focus-follows-mouse.enable = false;
      };

      spawn-at-startup = [
        { argv = [
            "dbus-update-activation-environment"
            "--systemd"
            "WAYLAND_DISPLAY"
            "DISPLAY"
            "XDG_CURRENT_DESKTOP"
            "XDG_SESSION_TYPE"
          ];
        }
        # Launch Noctalia shell on startup
        { argv = ["noctalia"]; }
        # Niri needs a polkit authentication agent
        { argv = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"]; }
      ];

      switch-events = {
        lid-close.action.spawn = ["systemctl" "suspend"];
      };

      layout = {
        gaps = 8;
        center-focused-column = "never";
        preset-column-widths = [
            { proportion = 0.33333; }
            { proportion = 0.5; }
            { proportion = 0.66667; }
        ];
        default-column-width = { proportion = 0.5; };
        focus-ring.enable = false;
        border.enable = false;
      };

      animations.enable = true;

      # Translate Hyprland Binds to Niri
      binds = {
        # --- Apps ---
        "Mod+Return".action.spawn = ["kitty"];
        "Mod+B".action.spawn = ["firefox"];
        "Mod+E".action.spawn = ["thunar"]; # File manager
        "Mod+Q".action.close-window = [];
        
        # --- Rofi / Launcher ---
        # "Alt+Space".action.spawn = ["rofi" "-show" "drun"];
        # Or you can use Noctalia's launcher:
        "Alt+Space".action.spawn = ["noctalia" "msg" "panel-toggle" "launcher"];

        # Notifications
        "Mod+N".action.spawn = ["noctalia" "msg" "panel-toggle" "control-center" "notifications"];

        # --- Utilities ---
        "Mod+C".action.screenshot = {}; # Niri's built-in screenshot
        "Mod+Shift+C".action.screenshot-screen = {};
        "Mod+L".action.spawn = ["hyprlock"]; # Lock screen using hyprlock
        "Mod+Shift+E".action.quit = { skip-confirmation = false; }; # Exit Niri

        # --- Window Management ---
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+V".action.center-column = []; # Toggle floating doesn't exist, centering is close

        # --- Focus Navigation (Arrow Keys) ---
        "Mod+Left".action.focus-column-left = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+Down".action.focus-window-down = [];

        # --- Move Windows (Shift + Arrow Keys) ---
        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Right".action.move-column-right = [];
        "Mod+Shift+Up".action.move-window-up = [];
        "Mod+Shift+Down".action.move-window-down = [];

        # --- Workspaces ---
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

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;
        "Mod+Shift+0".action.move-column-to-workspace = 10;

        # --- Niri Specific Awesome Binds ---
        # Scroll through columns like a ribbon (What makes Niri special)
        "Mod+WheelScrollDown".action.focus-column-right = [];
        "Mod+WheelScrollUp".action.focus-column-left = [];
        "Mod+Page_Down".action.focus-column-right = [];
        "Mod+Page_Up".action.focus-column-left = [];

        # Consume / Expel (Stacking windows vertically in a column)
        "Mod+Comma".action.consume-window-into-column = [];
        "Mod+Period".action.expel-window-from-column = [];
        
        # Change column width quickly
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";

        # --- Multimedia Keys ---
        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "s" "10%+"];
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "s" "10%-"];
        "XF86AudioNext".action.spawn = ["playerctl" "next"];
        "XF86AudioPause".action.spawn = ["playerctl" "play-pause"];
        "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
        "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
      };
    };
  };
}
