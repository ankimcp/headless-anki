#!/bin/bash
docker build --no-cache -t headless-anki:qt-vnc-v1.4.0 . && docker compose up
