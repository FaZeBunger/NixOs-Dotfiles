# Susanoo — System

<div class="module-meta"><span class="badge-host">host: susanoo</span> <span class="badge-system">system</span></div>
<p class="file-path">hosts/susanoo/default.nix</p>

## Overview

These are the notes and comments found in this configuration:

- Enable Hyprland
- programs.hyprland.enable = true;
- Enable xWayland apps to work
- programs.hyprland.xwayland.enable = true;
- Noctalia Greeter launches hyprland so remove the enable and just make sure it exists & tell the session what our displayManager is.
- Install UWSM's user systemd units so noctalia-greeter can launch wayland sessions
- Add portal config so hyprland.desktop appears.
- Disable bluetooth on wifi card
- Wifi uses Pcie for data while the bluetooth uses the usb that the cord connects to
- Make sure hibernation is disabled. (Causes boot errors)
- Pin to LTS kernel — linuxPackages_latest resolves to 7.2+ which breaks
- NVIDIA 595.x kernel module compilation (missing strncpy API). Override
- the common setting here until a fixed driver lands in nixpkgs stable.
- Enable NVIDIA drivers
- Modesetting is required.
- Nvidia power management. Experimental, and can cause sleep/suspend to fail.
- Enable this if you have graphical corruption issues or application crashes after waking
- up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
- of just the bare essentials.
- Fine-grained power management. Turns off GPU when not in use.

## Configuration

```nix
{{#include ../../../hosts/susanoo/default.nix}}
```
