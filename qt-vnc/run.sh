#!/bin/bash
docker build --no-cache -t headless-anki:qt-vnc-v1.6.0 . && docker compose up
