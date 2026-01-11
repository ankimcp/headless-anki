#!/bin/bash

# Start virtual X server
Xvfb :99 -screen 0 1920x1080x24 &
sleep 1

# Start window manager
openbox &
sleep 1

# Start VNC server
x11vnc -display :99 -forever -nopw -rfbport 5900 &
sleep 1

# Start Anki (restart if it exits)
while true; do
    anki -b /data
    echo "Anki exited, restarting in 2s..."
    sleep 2
done
