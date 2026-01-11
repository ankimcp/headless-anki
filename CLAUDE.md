# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minimal headless Anki Docker images using PyPI (`aqt` package). No authentication - just Anki in a container.

## Architecture

Image inheritance chain (build order matters):
```
base-1.0.0 → pypi-1.0.0 (offscreen)
           → x11-1.0.0 (VNC) → addons-1.0.0
```

| Directory | Tag | Mode |
|-----------|-----|------|
| `base/` | `headless-anki:base-1.0.0` | Base only (no CMD) |
| `pypi/` | `headless-anki:pypi-1.0.0` | `QT_QPA_PLATFORM=offscreen` |
| `pypi-x11/` | `headless-anki:x11-1.0.0` | Xvfb + openbox + x11vnc |
| `pypi-x11-addons/` | `headless-anki:addons-1.0.0` | X11 + addon install at build |

## Commands

```bash
# Build base first (required)
cd base && ./run.sh

# Build and run a variant
cd pypi-x11 && ./run.sh

# Build with addons
docker build --build-arg ADDON_IDS="2055492159" -t headless-anki:addons-1.0.0 pypi-x11-addons
docker compose -f pypi-x11-addons/docker-compose.yaml up
```

## Ports

| Port | Service |
|------|---------|
| 5900 | VNC |
| 8765 | AnkiConnect |
| 3141 | Anki MCP Server |

## Addon Handling

Download URL pattern:
```
https://ankiweb.net/shared/download/{id}?v=2.1&p={version_no_dots}
```
Example: version 25.9.2 → `p=2592`

AnkiConnect (ID 2055492159) is auto-patched to bind `0.0.0.0` for external access.

## Key Files

- `base/Dockerfile` - Base image with all Qt/X11 deps (no prefs21.db)
- `*/data/prefs21.db` - Pre-configured profile (skips first-run wizard)
- `pypi-x11/startup.sh` - X11 bootstrap (Xvfb → openbox → x11vnc → anki)
