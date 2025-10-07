#!/bin/bash

# Path to your cava config for Waybar (ensure this points to your config_waybar file)
CAVA_CONFIG_PATH="${HOME}/.config/cava/config_waybar"

# Define Unicode block characters for visualizer (0-8 levels, 9 total)
declare -a blocks=(" " " " "▂" "▃" "▄" "▅" "▆" "▇" "█")

# Function to get formatted cava bars
get_cava_bars() {
    # Run cava with its specific config and capture the first line of output
    # This relies on cava producing at least one line of output quickly
    cava_percentages=$(cava -p "$CAVA_CONFIG_PATH" 2>/dev/null | head -n 1)

    if [[ -n "$cava_percentages" ]]; then
        bars=""
        IFS=';' read -r -a ADDR <<< "$cava_percentages"
        for i in "${ADDR[@]}"; do
            # Validate if 'i' is a non-empty string of digits before arithmetic
            if [[ "$i" =~ ^[0-9]+$ ]]; then # Checks if 'i' consists only of digits
                # Convert percentage (0-100) to an index for the blocks array (0-8)
                index=$(( i / 12 ))
                if (( index > 8 )); then index=8; fi # This is line 20
                bars+="${blocks[index]}"
            else
                # If 'i' is not a valid number, append a placeholder or nothing
                bars+=" " # Add a space or some other placeholder for invalid data
            fi
        done
        echo "$bars"
    else
        echo "" # Return empty string if no cava output (e.g., no audio playing or cava fails)
    fi
}

# --- Main Logic ---

# Check current media player status
player_status=$(playerctl status 2>/dev/null)

if [[ "$player_status" == "Playing" || "$player_status" == "Paused" ]]; then
    # Media is playing: combine media name and visualizer
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    media_text=""

    if [[ -n "$artist" && -n "$title" ]]; then
        media_text="$artist - $title"
    elif [[ -n "$title" ]]; then
        media_text="$title"
    else
        media_text="Playing Media"
    fi

    # Get visualizer bars for the current moment
    visualizer_bars=$(get_cava_bars)

    # Output the combined string
    if [[ -n "$media_text" && -n "$visualizer_bars" ]]; then
        echo "$media_text  $visualizer_bars"
    elif [[ -n "$media_text" ]]; then
        echo "$media_text"
    else
        echo "$visualizer_bars"
    fi

else
    # No media playing: show window title
    window_title=$(hyprctl activewindow -j | jq -r '.title')
    if [[ "$window_title" == "null" || -z "$window_title" ]]; then
        echo ""
    else
        echo "$window_title"
    fi
fi
