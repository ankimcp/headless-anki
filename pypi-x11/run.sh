#!/bin/bash
docker build -t headless-anki:x11-1.0.0 . && docker compose up
