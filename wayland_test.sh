#/usr/bin/env bash

set -e

#podman run --rm --cap-add=SYS_NICE --cap-add=IPC_LOCK -ti ghcr.io/schneegans/gnome-shell-pod-33
podman run --rm --cap-add=SYS_NICE --cap-add=IPC_LOCK -ti ghcr.io/schneegans/gnome-shell-pod-38

# copy firefox in 
podman cp $(podman ps -q -n 1):/opt/Xvfb_screen0 .

# Start GNOME Shell.
systemctl --user start "gnome-xsession@:99"

# For example, you can run this command inside the container:
DISPLAY=:99 gnome-control-center
