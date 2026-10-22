# Ethan's NixOS Dotfiles

> A NixOS flake configuration managed with Home Manager, split across two
> hosts and organized into modular system & user modules.

## Hosts

| Host | Type | Description |
|------|------|-------------|
| **[susanoo](./hosts/susanoo-system.md)** | 🖥️ Desktop | NVIDIA GPU, GPU passthrough, gaming, extra drives |
| **[izanagi](./hosts/izanagi-system.md)** | 💻 Laptop | Portable setup, touchpad, lid-switch suspend |

## Architecture

```text
flake.nix
├── hosts/
│   ├── common/          ← Shared system & home-manager config
│   ├── susanoo/         ← Desktop-specific overrides
│   └── izanagi/         ← Laptop-specific overrides
├── modules/
│   ├── system/          ← NixOS system-level modules
│   └── user/            ← Home Manager user-level modules
└── configs/             ← Non-Nix config files (nvim, hypr, doom, …)
```

## Flake Inputs

| Input | Source |
|-------|--------|
| **nixpkgs** | `nixos-26.05` (stable) |
| **nixpkgs-unstable** | `nixos-unstable` |
| **home-manager** | `release-26.05` |
| **niri** | `sodiboo/niri-flake` |
| **noctalia** | `noctalia-dev/noctalia` |
| **noctalia-greeter** | `noctalia-dev/noctalia-greeter` |
| **antigravity** | `jacopone/antigravity-nix` |
