#!/bin/bash
docker build --no-cache -t headless-anki:qt-vnc-v1.2.1 . && docker compose up
