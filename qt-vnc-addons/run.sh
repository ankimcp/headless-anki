#!/bin/bash
ADDON_IDS="2055492159 124672614"
docker build --no-cache --build-arg ADDON_IDS="$ADDON_IDS" -t headless-anki:qt-vnc-addons-v1.2.0 . && docker compose up
