#!/bin/bash
docker build -t headless-anki:pypi-1.0.0 . && docker compose up
