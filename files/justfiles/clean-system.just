# vim: set ft=make :

# Clean up old up unused podman images, volumes, and rpm-ostree content
[group('Apps')]
clean-system:
    #!/usr/bin/bash
    podman image prune -af
    podman volume prune -f
    rpm-ostree cleanup -bm
    if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        brew cleanup
    fi
