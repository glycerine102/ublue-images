# vim: set ft=make :

# Update the system, firmware, homebrew packages, and flatpaks
[group('System')]
update: snap-apps
    #!/usr/bin/env bash
    /home/linuxbrew/.linuxbrew/bin/topgrade \
    --config "{{ "{{ config_directory() }}" }}/topgrade/topgrade.toml" --keep
