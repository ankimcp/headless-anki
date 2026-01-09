# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minimal headless Anki Docker image. No plugins, no authentication - just Anki running in offscreen/VNC mode. Designed for testing and public sharing.

Inspired by [ThisIsntTheWay/headless-anki](https://github.com/ThisIsntTheWay/headless-anki).

## Commands

```bash
# Build and run (no cache)
./run.sh

# Or manually
docker compose build --no-cache && docker compose up

# Just run (uses cached build)
docker compose up

# Build with specific Anki version
docker build --build-arg ANKI_VERSION=25.02.7 --build-arg QT_VERSION=6 -t headless-anki:latest .
```

## Key Files

- `Dockerfile` - Minimal Anki installation on Ubuntu 22.04
- `docker-compose.yaml` - Local dev setup with VNC enabled on port 5900
- `run.sh` - Build from scratch and run

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `ANKI_VERSION` | 25.02.7 | Anki release version (build arg) - see note below |
| `QT_VERSION` | 6 | Qt version (build arg) |
| `QT_QPA_PLATFORM` | offscreen | Qt platform - use `vnc` for VNC on port 5900 |

**Note:** Anki 25.07+ switched to a launcher-based distribution and no longer publishes standalone binaries on GitHub. Use 25.02.7 or earlier for Docker builds.

## Volumes

- `/data` - Anki data directory (profiles, collections)

## CI/CD

GitHub Actions workflow publishes to Docker Hub on push to main or release. Requires `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` secrets.
