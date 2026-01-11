#!/bin/bash

# Start Anki (restart if it exits)
while true; do
    anki -b /data
    echo "Anki exited, restarting in 2s..."
    sleep 2
done
