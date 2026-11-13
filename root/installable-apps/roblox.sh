#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Run this installer as root." >&2
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

if ! command -v flatpak >/dev/null 2>&1; then
    apt-get update
    apt-get install -y --no-install-recommends flatpak
fi

flatpak remote-add --system --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
flatpak install --system -y flathub org.vinegarhq.Sober

mkdir -p /usr/share/applications
cat > /usr/share/applications/roblox-sober.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Roblox (Sober)
Exec=flatpak run org.vinegarhq.Sober
Terminal=false
Categories=Game;
EOF
