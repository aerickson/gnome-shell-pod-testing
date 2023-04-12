#/usr/bin/env bash

set -e

container_name="gnome-shell-test"

#podman run --rm --cap-add=SYS_NICE --cap-add=IPC_LOCK -ti ghcr.io/schneegans/gnome-shell-pod-33
podman run --name "${container_name}" --rm --cap-add=SYS_NICE --cap-add=IPC_LOCK -ti ghcr.io/schneegans/gnome-shell-pod-38

# Start GNOME Shell.
systemctl --user start "gnome-xsession@:99"

# copy firefox in 
dnf install lbzip2 -y
podman cp firefox*.tar.bz2 $(podman ps -q -n 1):.

# For example, you can run this command inside the container:
#DISPLAY=:99 gnome-control-center
DISPLAY=:99 firefox about:config