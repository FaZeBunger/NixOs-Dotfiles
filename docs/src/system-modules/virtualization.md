# Virtualization

<div class="module-meta"><span class="badge-system">system</span></div>
<p class="file-path">modules/system/virtualization.nix</p>

## Overview

- Enable IOMMU and virtualization kernel modules
- These packages are already installed elsewhere but keep them
- here because they are important for virtualization kinda... 🫠
- Enable libvirt and virt-manager
- Add your user to the libvirtd group
- Add GPU rom to nixos and copy it to /etc/vgabios/rtx3060.rom

## Configuration

```nix
{{#include ../../../modules/system/virtualization.nix}}
```
