# vim: set ft=make :

[group('Apps')]
install-steam version="1.0.0.85-1":
    #!/usr/bin/env bash
    set -euo pipefail
    download_url="https://github.com/ivan-hc/Steam-appimage/releases/download/${version}/Steam-${version}-anylinux-x86_64.AppImage"
    download_dir="{{ home_directory() }}/Applications"
    mkdir -p "$download_dir"
    curl -L "$download_url" -o "$download_dir/Steam.AppImage"
    chmod 0755 "$download_dir/Steam.AppImage"
