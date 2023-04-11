#!/usr/bin/env bash

set -e

# Copy the framebuffer of xvfb.
podman cp $(podman ps -q -n 1):/opt/Xvfb_screen0 .

# Convert it to jpeg.
convert xwd:Xvfb_screen0 capture.jpg

# And finally display the image.
# This way we can see that GNOME Shell is actually up and running!
eog capture.jpg