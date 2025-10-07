#!/home/ebeyl/.nix-profile/bin/bash

# Explicitly set PATH to include common NixOS binary directories.
# This helps ensure commands are found when run by Waybar or other GUI launchers.
# Adjust if your NixOS setup places user binaries differently (e.g., if not using home-manager)
export PATH="/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH"

# --- Function to get media info ---
get_media_info() {
    player_status=$(playerctl status 2>/dev/null)
    if [[ "$player_status" == "Playing" || "$player_status" == "Paused" ]]; then
        artist=$(playerctl metadata artist 2>/dev/null)
        title=$(playerctl metadata title 2>/dev/null)
        if [[ -n "$artist" && -n "$title" ]]; then
            echo "$artist - $title"
        elif [[ -n "$title" ]]; then
            echo "$title"
        else
            echo "Playing Media"
        fi
        return 0 # Media is playing
    fi
    return 1 # No media playing
}

# --- Main Logic ---

media_output=$(get_media_info)

if [[ -n "$media_output" ]]; then
    # If media is playing, output media info
    echo "$media_output"
else
    # If no media is playing, output window title
    window_title=$(hyprctl activewindow -j | jq -r '.title')
    if [[ "$window_title" == "null" || -z "$window_title" ]]; then
        echo "" # Or a default message like "No active window"
    else
        echo "$window_title"
    fi
fi
