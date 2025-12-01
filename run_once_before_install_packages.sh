#!/bin/bash

# 1. Define your software list
# Added: ttf-jetbrains-mono (Standard) and ttf-jetbrains-mono-nerd (With Icons)
PACKAGES=(
    "alacritty"              # Terminal
    "ttf-jetbrains-mono"     # Standard JetBrains Mono
    "ttf-jetbrains-mono-nerd" # Nerd Font version (Required for icons)
    "zen-browser-bin"        # Browser
    "visual-studio-code-bin" # VS Code (Microsoft version)
    "discord"
    "spotify"
    "solaar"
    "bleachbit"
)

echo "🚀 Starting CachyOS Master Setup..."

# 2. Check for Paru (Failsafe)
if ! command -v paru &> /dev/null; then
    echo "Paru not found. Installing it..."
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru && makepkg -si && cd .. && rm -rf paru
fi

# 3. Install standard applications & Fonts
echo "📦 Installing applications and fonts..."
paru -S --needed --noconfirm "${PACKAGES[@]}"

# 4. Remove Firefox (Cleanup)
if pacman -Qs firefox > /dev/null; then
    echo "🗑️ Removing Firefox (since you are using Zen)..."
    sudo pacman -Rns --noconfirm firefox
else
    echo "✅ Firefox is already gone."
fi

# 5. Install DankMaterialShell via Official Script
if [ ! -d "$HOME/.config/DankMaterialShell" ]; then
    echo "🎨 Installing DankMaterialShell via official script..."
    curl -fsSL https://install.danklinux.com | sh
else
    echo "✅ DankMaterialShell seems to be installed already. Skipping installer."
fi

echo "✅ Software installation complete!"
