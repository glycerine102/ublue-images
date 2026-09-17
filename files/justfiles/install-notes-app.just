# vim: set ft=make :

[group('Apps')]
install-joplin version="3.7.14":
    #!/usr/bin/env bash
    set -euo pipefail

    app_name="Joplin"
    appimage_name="${app_name}-{{version}}.AppImage"
    download_url="https://github.com/laurent22/joplin/releases/download/v{{version}}/${appimage_name}"

    install_dir="{{ home_directory() }}/Applications"
    appimage_path="${install_dir}/${appimage_name}"
    extracted_path="${install_dir}/${app_name}.AppImage"
    previous_path="${install_dir}/.${app_name}.AppImage.previous"
    staging_path="${install_dir}/.${app_name}.AppImage.staging"

    mkdir -p "$install_dir"

    curl --fail --location --retry 3 --retry-all-errors \
        --output "$appimage_path" \
        "$download_url"
    chmod 0755 "$appimage_path"

    extract_workdir="$(mktemp -d)"
    trap 'rm -rf "$extract_workdir" "$staging_path"' EXIT

    rm -rf "$staging_path"

    (
        cd "$extract_workdir"
        "$appimage_path" --appimage-extract
    )

    test -x "$extract_workdir/squashfs-root/AppRun"
    mv "$extract_workdir/squashfs-root" "$staging_path"

    rm -rf "$previous_path"

    if [[ -e "$extracted_path" ]]; then
        mv "$extracted_path" "$previous_path"
    fi

    mv "$staging_path" "$extracted_path"
    rm -rf "$previous_path"
