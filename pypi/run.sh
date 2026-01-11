#!/bin/bash
docker build --no-cache -t headless-anki:pypi-1.0.0 . && docker compose up
