# Doomemacs

<div class="module-meta"><span class="badge-user">user / home-manager</span></div>
<p class="file-path">modules/user/doomemacs.nix</p>

## Overview

- Dependencies for emacs & doom emacs
- Core dependencies
- Needed for the terminal in emacs
- Needed to compile vterm
- LSP Packages
- Unity Packages for emacs support
- LSP support for C# files
- Note taking shit
- Required packages for math in emacs + much more
- Optional but recommended for code styling
- Add the emacs script to pkgs
- Required to parse Hyprland's JSON output
- Makes org roam graph view work
- Spell checking for UNIX (Needed for emacs spell checking)
- This should probably be under system or essentials but I'm putting it here because I'm building an emacs plugin with it rn lol
- Needed for org-download to work
- Needed to add rider2emacs to path so it can run for unity integration with emacs
- Add Emacs to the XDG entry
- Enable emacs by default so the daemon is always running
- native Wayland GUI support — important for daemon+GUI

## Configuration

```nix
{{#include ../../../modules/user/doomemacs.nix}}
```
