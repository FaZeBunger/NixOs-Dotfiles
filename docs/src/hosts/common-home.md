# Common — Home

<div class="module-meta"><span class="badge-host">common</span> <span class="badge-system">home</span></div>
<p class="file-path">hosts/common/home.nix</p>

This configuration is shared by **all hosts**.

## Overview

- Home Manager needs a bit of information about you and the paths it should
- manage.
- The home.packages option allows you to install Nix packages into your
- environment.
- Tells NixOS where to store the configs for programs managed by Nix
- Neovim must be able to modify the config files thus 
- we cannot use symlinks to the NixStore as it would be immutable
- This value determines the Home Manager release that your configuration is
- compatible with. This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
- You should not change this value, even if you update Home Manager. If you do
- want to update the value, then make sure to first check the Home Manager
- release notes.
- Please read the comment before changing.

## Configuration

```nix
{{#include ../../../hosts/common/home.nix}}
```
