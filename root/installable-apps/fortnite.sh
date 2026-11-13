#!/usr/bin/env bash
set -euo pipefail

mkdir -p /usr/share/applications
cat > /usr/share/applications/fortnite-cloud.desktop <<'EOF'
[Desktop Entry]
Type=Application
Name=Fortnite (Xbox Cloud Gaming)
Exec=firefox --new-window https://www.xbox.com/play/games/fortnite/bt5p2x999vh2
Terminal=false
Categories=Game;
EOF
