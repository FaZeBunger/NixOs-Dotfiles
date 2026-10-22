#!/usr/bin/env bash
# generate.sh — Auto-generates mdBook documentation from the dotfiles repo.
#
# Run from the repo root:
#   ./docs/generate.sh
#
# It walks hosts/, modules/, configs/, and scripts/ to produce markdown pages
# in docs/src/ with embedded {{#include}} directives (so the docs always
# reflect the live code) and builds the SUMMARY.md navigation.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOCS_SRC="$REPO_ROOT/docs/src"

# ── Helpers ──────────────────────────────────────────────────────────────────

# Convert a filename stem to a human-readable title.
# e.g. "minecraft-optimization" → "Minecraft Optimization"
titleize() {
  echo "$1" \
    | sed 's/[-_]/ /g' \
    | sed 's/\b\(.\)/\u\1/g'
}

# Detect the language tag for a file extension so mdBook highlights it.
lang_for_ext() {
  case "$1" in
    nix)   echo "nix"   ;;
    lua)   echo "lua"   ;;
    el)    echo "elisp" ;;
    conf)  echo "ini"   ;;
    toml)  echo "toml"  ;;
    rasi)  echo "css"   ;;
    sh)    echo "bash"  ;;
    json)  echo "json"  ;;
    org)   echo "text"  ;;
    *)     echo "text"  ;;
  esac
}

# Extract the leading block of # comments from a .nix file and strip the
# comment markers.  Returns empty string if the file doesn't start with
# comments (which is most of the time for this repo — that's fine).
extract_nix_header_comments() {
  local file="$1"
  # Skip the function arg line ({ pkgs, ... }:) and grab consecutive # lines
  awk '
    BEGIN { started=0 }
    /^[[:space:]]*#/ { started=1; sub(/^[[:space:]]*#+ ?/, ""); print; next }
    started { exit }
    /^[[:space:]]*\{.*\}:/ { next }  # skip arg line
    /^[[:space:]]*\{/      { next }
    /^[[:space:]]*$/        { next }  # skip blank lines before comments
    { exit }
  ' "$file"
}

# Extract *all* inline # comments from a .nix file, deduplicate, and return
# as a bullet list. This gives readers a quick overview of what's configured.
extract_nix_inline_comments() {
  local file="$1"
  (
    grep -oP '#\s+\K.+' "$file" 2>/dev/null \
      | grep -v '^\s*$' \
      | awk '!seen[$0]++' \
      | head -20 \
      | sed 's/^/- /'
  ) 2>/dev/null || true
}

# Extract imports from a .nix file and turn them into doc cross-links.
extract_imports() {
  local file="$1"
  { grep -oP '(?<=\./)[\w/.-]+\.nix' "$file" 2>/dev/null || true; } | sort -u
}

# ── Clean generated content ─────────────────────────────────────────────────

# Remove previously generated pages but keep custom.css and any hand-written
# files the user may have added (they can put them in docs/src/custom/).
find "$DOCS_SRC" -name '*.md' -delete 2>/dev/null || true
mkdir -p "$DOCS_SRC"/{hosts,system-modules,user-modules,configs,scripts}

# ── Index page ───────────────────────────────────────────────────────────────

cat > "$DOCS_SRC/index.md" << 'EOF'
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
EOF

# ── Generate host pages ─────────────────────────────────────────────────────

for host_dir in "$REPO_ROOT"/hosts/*/; do
  host_name="$(basename "$host_dir")"
  [[ "$host_name" == "common" ]] && continue

  # System config (default.nix)
  if [[ -f "$host_dir/default.nix" ]]; then
    out="$DOCS_SRC/hosts/${host_name}-system.md"
    title="$(titleize "$host_name") — System"
    rel_path="$(realpath --relative-to="$DOCS_SRC/hosts" "$host_dir/default.nix")"
    comments=$(extract_nix_inline_comments "$host_dir/default.nix")

    cat > "$out" << HEREDOC
# ${title}

<div class="module-meta"><span class="badge-host">host: ${host_name}</span> <span class="badge-system">system</span></div>
<p class="file-path">hosts/${host_name}/default.nix</p>

HEREDOC

    if [[ -n "$comments" ]]; then
      cat >> "$out" << HEREDOC
## Overview

These are the notes and comments found in this configuration:

${comments}

HEREDOC
    fi

    cat >> "$out" << HEREDOC
## Configuration

\`\`\`nix
{{#include ${rel_path}}}
\`\`\`
HEREDOC
  fi

  # Home config
  if [[ -f "$host_dir/home.nix" ]]; then
    out="$DOCS_SRC/hosts/${host_name}-home.md"
    title="$(titleize "$host_name") — Home"
    rel_path="$(realpath --relative-to="$DOCS_SRC/hosts" "$host_dir/home.nix")"
    comments=$(extract_nix_inline_comments "$host_dir/home.nix")

    cat > "$out" << HEREDOC
# ${title}

<div class="module-meta"><span class="badge-host">host: ${host_name}</span> <span class="badge-user">home-manager</span></div>
<p class="file-path">hosts/${host_name}/home.nix</p>

HEREDOC

    if [[ -n "$comments" ]]; then
      cat >> "$out" << HEREDOC
## Overview

${comments}

HEREDOC
    fi

    cat >> "$out" << HEREDOC
## Configuration

\`\`\`nix
{{#include ${rel_path}}}
\`\`\`
HEREDOC
  fi

  # Hardware config
  if [[ -f "$host_dir/hardware-configuration.nix" ]]; then
    out="$DOCS_SRC/hosts/${host_name}-hardware.md"
    title="$(titleize "$host_name") — Hardware"
    rel_path="$(realpath --relative-to="$DOCS_SRC/hosts" "$host_dir/hardware-configuration.nix")"

    cat > "$out" << HEREDOC
# ${title}

<div class="module-meta"><span class="badge-host">host: ${host_name}</span> <span class="badge-system">hardware</span></div>
<p class="file-path">hosts/${host_name}/hardware-configuration.nix</p>

> ⚠️ This file is auto-generated by \`nixos-generate-config\`. It describes the
> hardware of the **${host_name}** host.

\`\`\`nix
{{#include ${rel_path}}}
\`\`\`
HEREDOC
  fi
done

# Common host files
for common_file in "$REPO_ROOT"/hosts/common/*.nix; do
  stem="$(basename "$common_file" .nix)"
  out="$DOCS_SRC/hosts/common-${stem}.md"
  title="Common — $(titleize "$stem")"
  rel_path="$(realpath --relative-to="$DOCS_SRC/hosts" "$common_file")"
  comments=$(extract_nix_inline_comments "$common_file")

  cat > "$out" << HEREDOC
# ${title}

<div class="module-meta"><span class="badge-host">common</span> <span class="badge-system">${stem}</span></div>
<p class="file-path">hosts/common/$(basename "$common_file")</p>

This configuration is shared by **all hosts**.

HEREDOC

  if [[ -n "$comments" ]]; then
    cat >> "$out" << HEREDOC
## Overview

${comments}

HEREDOC
  fi

  cat >> "$out" << HEREDOC
## Configuration

\`\`\`nix
{{#include ${rel_path}}}
\`\`\`
HEREDOC
done

# ── Generate module pages ───────────────────────────────────────────────────

generate_module_page() {
  local file="$1" category="$2" out_dir="$3" badge_class="$4"
  local stem
  stem="$(basename "$file" .nix)"
  local out="${out_dir}/${stem}.md"
  local title
  title="$(titleize "$stem")"
  local rel_path
  rel_path="$(realpath --relative-to="$out_dir" "$file")"
  local repo_rel_path="${file#$REPO_ROOT/}"
  local comments
  comments=$(extract_nix_inline_comments "$file")

  cat > "$out" << HEREDOC
# ${title}

<div class="module-meta"><span class="${badge_class}">${category}</span></div>
<p class="file-path">${repo_rel_path}</p>

HEREDOC

  if [[ -n "$comments" ]]; then
    cat >> "$out" << HEREDOC
## Overview

${comments}

HEREDOC
  fi

  cat >> "$out" << HEREDOC
## Configuration

\`\`\`nix
{{#include ${rel_path}}}
\`\`\`
HEREDOC
}

for f in "$REPO_ROOT"/modules/system/*.nix; do
  generate_module_page "$f" "system" "$DOCS_SRC/system-modules" "badge-system"
done

for f in "$REPO_ROOT"/modules/user/*.nix; do
  generate_module_page "$f" "user / home-manager" "$DOCS_SRC/user-modules" "badge-user"
done

# ── Generate config pages ───────────────────────────────────────────────────

for config_dir in "$REPO_ROOT"/configs/*/; do
  config_name="$(basename "$config_dir")"
  out="$DOCS_SRC/configs/${config_name}.md"
  title="$(titleize "$config_name") Config"

  cat > "$out" << HEREDOC
# ${title}

<div class="module-meta"><span class="badge-config">config</span></div>

Non-Nix configuration files for **${config_name}**.

HEREDOC

  # Include each file in the config directory (skip subdirectories named "old"
  # or "snippets", and skip binary / lock / spacenamed files)
  find "$config_dir" -type f \
    -not -path '*/old/*' \
    -not -path '*/snippets/*' \
    -not -name '*.json' \
    -not -name '*.lock' \
    -not -name '* *' \
    | sort \
    | while read -r cfg_file; do
      cfg_rel="${cfg_file#$REPO_ROOT/}"
      cfg_basename="$(basename "$cfg_file")"
      ext="${cfg_basename##*.}"
      lang=$(lang_for_ext "$ext")
      include_path="$(realpath --relative-to="$DOCS_SRC/configs" "$cfg_file")"

      cat >> "$out" << HEREDOC

## \`${cfg_rel}\`

\`\`\`${lang}
{{#include ${include_path}}}
\`\`\`

HEREDOC
    done
done

# ── Generate scripts page ───────────────────────────────────────────────────

if [[ -d "$REPO_ROOT/scripts" ]] && ls "$REPO_ROOT"/scripts/* &>/dev/null; then
  out="$DOCS_SRC/scripts/index.md"
  cat > "$out" << HEREDOC
# Scripts

Utility scripts stored in the dotfiles repo.

HEREDOC

  for script in "$REPO_ROOT"/scripts/*; do
    script_name="$(basename "$script")"
    ext="${script_name##*.}"
    lang=$(lang_for_ext "$ext")
    include_path="$(realpath --relative-to="$DOCS_SRC/scripts" "$script")"

    cat >> "$out" << HEREDOC

## \`${script_name}\`

\`\`\`${lang}
{{#include ${include_path}}}
\`\`\`

HEREDOC
  done
fi

# ── Generate SUMMARY.md ─────────────────────────────────────────────────────

cat > "$DOCS_SRC/SUMMARY.md" << 'EOF'
# Summary

[Introduction](./index.md)

---

EOF

# Hosts section
echo "# Hosts" >> "$DOCS_SRC/SUMMARY.md"
echo "" >> "$DOCS_SRC/SUMMARY.md"

# Common first
for f in "$DOCS_SRC"/hosts/common-*.md; do
  [[ -f "$f" ]] || continue
  stem="$(basename "$f" .md)"
  # Extract title from the file
  title=$(head -1 "$f" | sed 's/^# //')
  echo "- [${title}](./hosts/${stem}.md)" >> "$DOCS_SRC/SUMMARY.md"
done

# Then each host
for host_dir in "$REPO_ROOT"/hosts/*/; do
  host_name="$(basename "$host_dir")"
  [[ "$host_name" == "common" ]] && continue
  host_title="$(titleize "$host_name")"

  # System page
  if [[ -f "$DOCS_SRC/hosts/${host_name}-system.md" ]]; then
    echo "- [${host_title} — System](./hosts/${host_name}-system.md)" >> "$DOCS_SRC/SUMMARY.md"
  fi
  # Home page
  if [[ -f "$DOCS_SRC/hosts/${host_name}-home.md" ]]; then
    echo "  - [${host_title} — Home](./hosts/${host_name}-home.md)" >> "$DOCS_SRC/SUMMARY.md"
  fi
  # Hardware page
  if [[ -f "$DOCS_SRC/hosts/${host_name}-hardware.md" ]]; then
    echo "  - [${host_title} — Hardware](./hosts/${host_name}-hardware.md)" >> "$DOCS_SRC/SUMMARY.md"
  fi
done

echo "" >> "$DOCS_SRC/SUMMARY.md"

# System modules section
echo "# System Modules" >> "$DOCS_SRC/SUMMARY.md"
echo "" >> "$DOCS_SRC/SUMMARY.md"
for f in "$DOCS_SRC"/system-modules/*.md; do
  [[ -f "$f" ]] || continue
  stem="$(basename "$f" .md)"
  title="$(titleize "$stem")"
  echo "- [${title}](./system-modules/${stem}.md)" >> "$DOCS_SRC/SUMMARY.md"
done
echo "" >> "$DOCS_SRC/SUMMARY.md"

# User modules section
echo "# User Modules" >> "$DOCS_SRC/SUMMARY.md"
echo "" >> "$DOCS_SRC/SUMMARY.md"
for f in "$DOCS_SRC"/user-modules/*.md; do
  [[ -f "$f" ]] || continue
  stem="$(basename "$f" .md)"
  title="$(titleize "$stem")"
  echo "- [${title}](./user-modules/${stem}.md)" >> "$DOCS_SRC/SUMMARY.md"
done
echo "" >> "$DOCS_SRC/SUMMARY.md"

# Configs section
echo "# Configs" >> "$DOCS_SRC/SUMMARY.md"
echo "" >> "$DOCS_SRC/SUMMARY.md"
for f in "$DOCS_SRC"/configs/*.md; do
  [[ -f "$f" ]] || continue
  stem="$(basename "$f" .md)"
  title="$(titleize "$stem") Config"
  echo "- [${title}](./configs/${stem}.md)" >> "$DOCS_SRC/SUMMARY.md"
done
echo "" >> "$DOCS_SRC/SUMMARY.md"

# Scripts section
if [[ -f "$DOCS_SRC/scripts/index.md" ]]; then
  echo "# Extras" >> "$DOCS_SRC/SUMMARY.md"
  echo "" >> "$DOCS_SRC/SUMMARY.md"
  echo "- [Scripts](./scripts/index.md)" >> "$DOCS_SRC/SUMMARY.md"
  echo "" >> "$DOCS_SRC/SUMMARY.md"
fi

echo "✅ Documentation generated in $DOCS_SRC"
echo "   Run 'mdbook serve docs/' to preview locally."
