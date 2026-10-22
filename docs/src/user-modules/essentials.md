# Essentials

<div class="module-meta"><span class="badge-user">user / home-manager</span></div>
<p class="file-path">modules/user/essentials.nix</p>

## Overview

- A python download manager for linux. Since free download manager isn't in the nix store
- WinDirStat for Linux
- Mounting / Reading / Writing to USB drives
- Hex Editor
- RDP, VNC, SSH Client
- VNC Server for wayland
- DE PKGS
- What Hyprland is built on
- Lockscreen for Hyprland
- Idle Manager for Hyprland
- Color Picker for Hyprland
- Hyprland Idle Daemon
- Hyprland Wallpaper Daemon
- Mouse Cursor
- Audio Visualizer
- Notification PKGS
- pkgs.swaynotificationcenter   # A Notification Center with GUI | REMOVED because quickshell has it's own notification stuff
- Brightness Manager (SwayNC needs this)
- SwayNC needs this
- REQUIRED BY DEFAULT FOR HYPRLAND

## Configuration

```nix
{{#include ../../../modules/user/essentials.nix}}
```
