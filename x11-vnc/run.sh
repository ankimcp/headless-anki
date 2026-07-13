#!/bin/bash
docker build --no-cache -t headless-anki:x11-vnc-v1.2.1 . && docker compose up
