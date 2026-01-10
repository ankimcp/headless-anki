#!/bin/bash
ADDON_IDS="2055492159"
docker build --no-cache --build-arg ADDON_IDS="$ADDON_IDS" -t headless-anki:addons . && docker compose up
