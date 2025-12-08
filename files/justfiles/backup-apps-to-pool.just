# vim: set ft=make :

# Copy app data over to the zpool from root ssd
[group('Backup')]
sync-apps:
    rsync -a --info=progress2 --delete "{{ home_directory() }}/.var/app/" "{{ home_directory() }}/.appdata/flatpak/"
    rsync -a --info=progress2 --delete "/home/linuxbrew/.linuxbrew/" "{{ home_directory() }}/.appdata/homebrew/"

# ZFS snapshot the app data directory
[group('Backup')]
snap-apps: sync-apps
    #!/usr/bin/env bash
    timestamp=$(date +%F_%T)
    zfs snapshot "storage/applications/flatpak@autosnap_${timestamp}_frequently"
    zfs snapshot "storage/applications/homebrew@autosnap_${timestamp}_frequently"
