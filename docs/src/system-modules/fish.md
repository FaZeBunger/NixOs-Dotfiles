# Fish

<div class="module-meta"><span class="badge-system">system</span></div>
<p class="file-path">modules/system/fish.nix</p>

## Overview

- This file is required to make sure that the system shell stays as bash since linux requires
- POSIX languages. Otherwise if we are in an interactive shell, we will use fish.
- "check if parent process is not fish" && "make nested shells work properly"
- set $SHELL for better integration with programs like nix shell, tmux, etc.

## Configuration

```nix
{{#include ../../../modules/system/fish.nix}}
```
