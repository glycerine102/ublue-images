#!/usr/bin/env bash

set -ouex pipefail

dnf5 install -y https://zfsonlinux.org/fedora/zfs-release-3-0$(rpm --eval "%{dist}").noarch.rpm
dnf5 install -y kernel-devel-"$(rpm -qa kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')"
dnf5 --disablerepo=zfs --enablerepo=zfs-2.3 install -y zfs

depmod -a "$(rpm -qa kernel --queryformat '%{VERSION}-%{RELEASE}.%{ARCH}')" && \
echo "zfs" > /etc/modules-load.d/zfs.conf && \
echo "zfs" > /etc/dnf/protected.d/zfs.conf
