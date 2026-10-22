# Izanagi — System

<div class="module-meta"><span class="badge-host">host: izanagi</span> <span class="badge-system">system</span></div>
<p class="file-path">hosts/izanagi/default.nix</p>

## Overview

These are the notes and comments found in this configuration:

- Enable Niri on laptop
- Since moving to the noctalia-greeter we don't need to enable greetd since noctalia-greeter already does it
- I'm keeping this here since I don't want to completely remove this incase the noctalia-greeter doesn't work/breaks
- services.greetd.enable = true;
- services.greetd.settings.default_session = {
- command = "niri-session";
- user = "ebeyl";
- };
- Make sure these are on for Noctalia

## Configuration

```nix
{{#include ../../../hosts/izanagi/default.nix}}
```
