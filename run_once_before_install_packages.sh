#!/bin/bash

# 1. Define your software list
PACKAGES=(
    "alacritty"              # Terminal
    "ttf-jetbrains-mono"     # Fonts
    "ttf-jetbrains-mono-nerd"
    "adw-gtk-theme"          # <--- Added: Makes GTK3 apps look like Libadwaita
    "zen-browser-bin"        # Browser
    "visual-studio-code-bin" # VS Code
    "discord"
    "spotify"
    "solaar"
    "bleachbit"
)

echo "🚀 Starting CachyOS Master Setup..."

# 2. Check for Paru
if ! command -v paru &> /dev/null; then
    echo "Paru not found. Installing it..."
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru && makepkg -si && cd .. && rm -rf paru
fi

# 3. Install applications
echo "📦 Installing applications, fonts, and themes..."
paru -S --needed --noconfirm "${PACKAGES[@]}"

# 4. Apply the GTK Theme (Dark Mode)
# This ensures GTK3 apps use the new theme immediately
echo "🎨 Applying Adw-GTK3 Dark Theme..."
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# 5. Remove Firefox
if pacman -Qs firefox > /dev/null; then
    echo "🗑️ Removing Firefox..."
    sudo pacman -Rns --noconfirm firefox
else
    echo "✅ Firefox is already gone."
fi

# 6. Install DankMaterialShell
if [ ! -d "$HOME/.config/DankMaterialShell" ]; then
    echo "🎨 Installing DankMaterialShell via official script..."
    curl -fsSL https://install.danklinux.com | sh
else
    echo "✅ DankMaterialShell seems to be installed. Skipping."
fi

echo "✅ Software installation complete!"
