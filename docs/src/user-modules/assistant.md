# Assistant

<div class="module-meta"><span class="badge-user">user / home-manager</span></div>
<p class="file-path">modules/user/assistant.nix</p>

## Overview

- services.ollama.enable = true;
- services.ollama.acceleration = "cuda";
- services.ollama.package = pkgs.ollama;
- services.ollama.environmentVariables = {
- OLLAMA_ORIGINS = "*";
- }; 
- services.ollama.host = "0.0.0.0";
- services.llama-cpp = {
- package = ;
- enable = true;
- host = "0.0.0.0";
- port = "42069";
- modelsDir = "${config.home.homeDirectory}/LLMS"

## Configuration

```nix
{{#include ../../../modules/user/assistant.nix}}
```
