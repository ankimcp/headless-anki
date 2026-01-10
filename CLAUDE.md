# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minimal headless Anki Docker images using PyPI (`aqt` package). No plugins, no authentication - just Anki for testing.

Inspired by [ThisIsntTheWay/headless-anki](https://github.com/ThisIsntTheWay/headless-anki).

## Variants

| Variant | Description |
|---------|-------------|
| `pypi/` | Basic Qt VNC, no window manager |
| `pypi-x11/` | Xvfb + openbox + x11vnc, full window decorations |

## Commands

```bash
# Build and run (no cache)
cd pypi      # or pypi-x11
./run.sh

# Just run (uses cached build)
docker compose up

# Build specific version
docker build --build-arg ANKI_VERSION=25.9.2 -t headless-anki:latest .
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `ANKI_VERSION` | 25.9.2 | Any version from 2.1.24+ |
| `QT_QPA_PLATFORM` | vnc/xcb | Qt platform (pypi uses vnc, pypi-x11 uses xcb) |

## Key Files

- `pypi/Dockerfile` - Python 3.12 slim + uv + Qt VNC
- `pypi-x11/Dockerfile` - Same + Xvfb + openbox + x11vnc
- `*/data/prefs21.db` - Pre-configured profile (skips first-run wizard)
- `*/startup.sh` - X11 startup script (pypi-x11 only)

## Volumes

- `/data` - Anki data directory (profiles, collections)

## VNC Access

Both variants expose VNC on port 5900. Connect with any VNC client to `localhost:5900`.
