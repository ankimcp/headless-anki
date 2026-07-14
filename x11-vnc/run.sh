#!/bin/bash
docker build --no-cache -t headless-anki:x11-vnc-v1.4.0 . && docker compose up
