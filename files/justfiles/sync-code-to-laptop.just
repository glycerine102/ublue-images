# vim: set ft=make :

# Copy Developer data over to the laptop
[group('Backup')]
sync-code:
    rsync -a --info=progress2 --delete $WORKSTATION_HOSTNAME:$WORKSTATION_CODE_PATH "{{ home_directory() }}/$LAPTOP_CODE_PATH"
