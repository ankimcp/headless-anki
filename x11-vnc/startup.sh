#!/bin/bash

# Start X server + VNC server as a single process (TigerVNC Xvnc).
# Replaces the old Xvfb + x11vnc pair: one in-process framebuffer, no
# cross-process scrape. No -localhost here — a VNC client connects
# directly to the published port 5900.
Xvnc :99 \
    -geometry 1920x1080 -depth 24 \
    -rfbport 5900 \
    -SecurityTypes None \
    -AlwaysShared \
    -desktop Anki \
    -nolisten tcp &

# Wait for the X server to be ready (creates /tmp/.X11-unix/X99)
for _ in $(seq 1 50); do
    [ -e /tmp/.X11-unix/X99 ] && break
    sleep 0.2
done

# Start window manager
openbox &
sleep 1

# Start Anki (restart if it exits)
while true; do
    anki -b /data
    echo "Anki exited, restarting in 2s..."
    sleep 2
done
