#!/bin/bash

echo "Checking if hyprpaper is already running..."

# Start hyprpaper in the background if it's not already running
if ! pgrep -x "hyprpaper" > /dev/null; then
    echo "hyprpaper is not running. Starting hyprpaper in the background..."
    hyprpaper &  # Start hyprpaper in the background
    echo "Waiting for hyprpaper to initialize..."
    sleep 1  # Wait a moment to ensure hyprpaper starts and creates the socket
else
    echo "hyprpaper is already running."
fi

# Directory containing your wallpapers
WALLPAPER_DIR="/home/yann/.config/hypr/Wallpapers/"

echo "Selecting a random wallpaper from $WALLPAPER_DIR..."

# Get a random wallpaper from the directory
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.png" -o -name "*.jpg" \) | shuf -n 1)

echo "Random wallpaper selected: $RANDOM_WALLPAPER"

# Preload the wallpaper
echo "Preloading the selected wallpaper..."
hyprctl hyprpaper preload "$RANDOM_WALLPAPER"

# Apply the wallpaper to all monitors
echo "Applying the wallpaper to all monitors..."
hyprctl hyprpaper wallpaper "eDP-1, $RANDOM_WALLPAPER"


echo "Wallpaper has been applied successfully."
