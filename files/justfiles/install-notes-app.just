# vim: set ft=make :

[group('Apps')]
install-joplin version="3.7.14":
    #!/usr/bin/env bash
    set -euo pipefail

    app_name="Joplin"
    appimage_name="${app_name}-${version}.AppImage"

    download_url="https://github.com/laurent22/joplin/releases/download/v${version}/${appimage_name}"
    download_dir="{{ home_directory() }}/Applications"
    appimage_path="${download_dir}/${appimage_name}"
    extract_dir="${download_dir}/${app_name}.AppImage"

    mkdir -p "$download_dir"

    curl --fail --location --output "$appimage_path" "$download_url"
    chmod 0755 "$appimage_path"

    work_dir="$(mktemp -d)"
    trap 'rm -rf "$work_dir"' EXIT

    (
        cd "$work_dir"
        "$appimage_path" --appimage-extract
    )

    rm -rf "$extract_dir"
    mv "$work_dir/squashfs-root" "$extract_dir"
