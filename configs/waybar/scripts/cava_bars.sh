#!/bin/bash

# Define Unicode block characters for visualizer (from empty to full)
# The first two are usually spaces or very thin bars to represent low levels
declare -a blocks=(" " " " "▂" "▃" "▄" "▅" "▆" "▇" "█") # 9 levels (0-8)

# Run cava with its specific config file and pipe its output
cava -p ~/.config/cava/config_waybar 2>/dev/null | while IFS=';' read -r -a percentages; do
    bars=""
    for p in "${percentages[@]}"; do
        # Convert percentage (0-100) to an index for the blocks array (0-8)
        index=$(( p / 12 )) # Divide by 12 to map 0-100 to 0-8 (100 / 9 levels ~ 11.1 per level)
        if (( index > 8 )); then index=8; fi # Cap at the maximum index
        bars+="${blocks[index]}"
    done
    echo "$bars" # Output the formatted bars
done
