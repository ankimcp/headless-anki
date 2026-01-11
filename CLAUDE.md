# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minimal headless Anki Docker images using PyPI (`aqt` package). No authentication - just Anki in a container.

## Architecture

Image inheritance chain (build order matters):
```
base → qt-vnc (Qt VNC plugin)
     → x11-vnc (Xvfb + openbox + x11vnc) → addons
```

| Directory | Tag | Mode |
|-----------|-----|------|
| `base/` | `base-vX.X.X` | Base only (no CMD) |
| `qt-vnc/` | `qt-vnc-vX.X.X` | `QT_QPA_PLATFORM=vnc` (lightweight) |
| `x11-vnc/` | `x11-vnc-vX.X.X` | Xvfb + openbox + x11vnc (full desktop) |
| `x11-vnc-addons/` | `addons-vX.X.X` | X11 + addon install at build |

## Releases

Push a git tag to trigger CI build and GitHub release:
```bash
git tag v1.0.0 && git push origin v1.0.0
```

This builds and pushes to ghcr.io:
- `ghcr.io/ankimcp/headless-anki:base-v1.0.0`
- `ghcr.io/ankimcp/headless-anki:qt-vnc-v1.0.0`
- `ghcr.io/ankimcp/headless-anki:x11-vnc-v1.0.0`

Note: `addons` is not built in CI (local only).

## Local Development

```bash
# Build base first (required)
cd base && ./run.sh

# Build and run a variant
cd x11-vnc && ./run.sh

# Build with addons
cd x11-vnc-addons
docker build --build-arg ADDON_IDS="2055492159" -t headless-anki:addons-v1.0.0 .
docker compose up
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
- `x11-vnc/startup.sh` - X11 bootstrap (Xvfb → openbox → x11vnc → anki)
