# vim: set ft=make :

# Download Steam AppImage
[group('Apps')]
install-steam:
    #!/usr/bin/env bash
    set -euo pipefail
    download_url="https://github.com/ivan-hc/Steam-appimage/releases/latest/download/Steam-1.0.0.85-1-anylinux-x86_64.AppImage"
    download_dir="{{ home_directory() }}/Applications"
    curl -L "$download_url" -o "$download_dir/Steam.AppImage"
    chmod 0755 $download_dir/Steam.AppImage
