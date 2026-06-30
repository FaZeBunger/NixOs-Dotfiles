These are my NixOS dotfiles. 

I use home-manager and nix flakes to keep everything tidy.
This configuration is split between my desktop and my laptop and desktop.

These dotfiles are not meant to be completely reproducible, nor as a template for others.
They are here for me to store and sync files between hosts, as well as to serve as an example for what 
one NixOS configuration with may look like.

My desktop configuration is also set up with Single GPU Passthrough with a hook script I made to realease my GPU and drives.
I do not recommend using my setup for personal use, but if you do I recommend that you do your research and make sure to customize the files for your host.


---
# TODOs 
- TODO: Make SwayNC finally look nice.
- TODO: Set up KDE Connect?
- TODO: Customize up starship
- TODO: Set up anti-virus scan to run automatically
- TODO: Add CPU usage tracker in waybar
- TODO: Configure starship to work with nix-shell and show custom prompt for it
- TODO: Set up nix to track doom-emacs and config. It only technically works right now.
- TODO: Fix unused variables and clean shit up
- TODO: Set up auto shutdown for desktop specifically.

--- 

# Requirements 
`cargo install rider2emacs` for unity lsp support
`cargo install matugen` for color themeing for quickshell
