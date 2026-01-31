#!/bin/bash
docker build --no-cache -t headless-anki:x11-vnc-v1.2.0 . && docker compose up
