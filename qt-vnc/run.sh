#!/bin/bash
docker build --no-cache -t headless-anki:qt-vnc-v1.2.0 . && docker compose up
