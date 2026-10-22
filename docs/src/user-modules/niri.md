# Niri

<div class="module-meta"><span class="badge-user">user / home-manager</span></div>
<p class="file-path">modules/user/niri.nix</p>

## Overview

- This is needed to run X11 apps on wayland
- Tells HM to link the icon files to ~/.icons and ~/.local/share/icons
- Launch Noctalia shell on startup
- Niri needs a polkit authentication agent
- Translate Hyprland Binds to Niri
- --- Apps ---
- File manager
- --- Rofi / Launcher ---
- "Alt+Space".action.spawn = ["rofi" "-show" "drun"];
- Or you can use Noctalia's launcher:
- Notifications
- --- Utilities ---
- Niri's built-in screenshot
- Exit Niri
- --- Window Management ---
- Toggle floating doesn't exist, centering is close
- --- Focus Navigation (Arrow Keys) ---
- --- Move Windows (Shift + Arrow Keys) ---
- --- Workspaces ---
- --- Niri Specific Awesome Binds ---

## Configuration

```nix
{{#include ../../../modules/user/niri.nix}}
```
