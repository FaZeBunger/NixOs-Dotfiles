# Common — System

<div class="module-meta"><span class="badge-host">common</span> <span class="badge-system">system</span></div>
<p class="file-path">hosts/common/system.nix</p>

This configuration is shared by **all hosts**.

## Overview

- Hardware configuration is handled per-host
- Enable Tailscale
- We define this here even though we manage noctalia mostly on the user level,
- our greeter runs before we login and should get the direct path to things like what the cursor should look like
- Ensures the greeter service is active
- Enable Docker
- Enable ClamAV AntiVirus
- Install GnuPG for encryption and
- Configure the GPG Agent daemon and password entry tool
- Smart card daemon service (highly recommended for GPG operations)
- Enable CUPS to print documents.
- Enable udisks2 for USB drives
- Enable ratbagd for mouse control
- Enable drivers - Example for HP
- Enable network discovery
- Allow Unfree Packages
- NixOS Insecure Packages
- Unstable Packages
- 500 MB
- Bootloader. Make sure to configure it properly!

## Configuration

```nix
{{#include ../../../hosts/common/system.nix}}
```
