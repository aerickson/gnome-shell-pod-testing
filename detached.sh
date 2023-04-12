#!/usr/bin/env bash

set -e
set -x

# debugging/dev cleanup
podman kill -a

# Run the container in detached mode.
POD=$(podman run --rm --cap-add=SYS_NICE --cap-add=IPC_LOCK -td ghcr.io/schneegans/gnome-shell-pod-33)

do_in_pod() {
  podman exec --user gnomeshell --workdir /home/gnomeshell "${POD}" set-env.sh "$@"
}

# place firefox
podman cp firefox-112.0.tar.bz2 "$POD":/home/gnomeshell/firefox.tar.bz2

# Install the gnome-backgrounds package.
#do_in_pod sudo dnf -y install gnome-backgrounds lbzip2
do_in_pod sudo dnf -y install lbzip2

# expand ff
do_in_pod tar -xf firefox.tar.bz2

# Set GNOME Shell's background image. This requires a D-Bus connection,
# so we wrap the command in the set-env.sh script.
#do_in_pod gsettings set org.gnome.desktop.background picture-uri \
#          "file:///usr/share/backgrounds/gnome/adwaita-day.jpg"


# Wait until the user bus is available.
do_in_pod wait-user-bus.sh 

# Start GNOME Shell.
#do_in_pod systemctl --user start "gnome-xsession@:99"
# TODO: use wayland
do_in_pod systemctl --user start "gnome-wayland-nested:*"
#gnome-wayland-nested@.service 

# Wait some time until GNOME Shell has been started.
sleep 3

# run firefox
do_in_pod ./firefox/firefox www.mozilla.org &

# sleep a bit
sleep 2

# Now make a screenshot and show it!
podman cp ${POD}:/opt/Xvfb_screen0 . && \
       convert xwd:Xvfb_screen0 capture.jp && \
       eog capture.jpg

# Now we can stop the container again.
podman stop ${POD}
