# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minimal headless Anki Docker images using PyPI (`aqt` package). No authentication - just Anki in a container.

## Architecture

Image inheritance chain (build order matters):
```
base (python:3.12-slim + aqt + Qt/X11 deps)
  ├── qt-vnc   (QT_QPA_PLATFORM=vnc, lightweight)
  └── x11-vnc  (Xvfb + openbox + x11vnc, full desktop)
        └── x11-vnc-addons  (addons baked in at build time)
```

Each variant's Dockerfile takes a `BASE_TAG` (or `X11_TAG`) ARG defaulting to `ghcr.io/ankimcp/headless-anki:base-v1.2.1`. CI overrides this; locally it uses the default.

**qt-vnc vs x11-vnc**: qt-vnc uses Qt's built-in VNC QPA plugin (set via docker-compose env, Dockerfile itself sets `offscreen`). x11-vnc runs a real X server stack (Xvfb → openbox → x11vnc → anki) in `startup.sh`.

## Local Development

```bash
# Build base first (required by all variants)
cd base && ./run.sh

# Build and run a variant (each run.sh builds + docker compose up)
cd x11-vnc && ./run.sh
cd qt-vnc && ./run.sh

# Build with addons
cd x11-vnc-addons
docker build --build-arg ADDON_IDS="2055492159" -t headless-anki:addons-v1.2.1 .
docker compose up
```

Version tags are hardcoded to `v1.2.1` in `run.sh` and `docker-compose.yaml` files. When bumping versions, update these across all variant directories.

## Releases (CI)

Push a git tag (`v*`) to trigger `.github/workflows/docker.yaml`:
1. Builds `base` image (multi-platform: amd64 + arm64)
2. Builds `qt-vnc` and `x11-vnc` in parallel, passing `BASE_TAG` from step 1
3. Creates GitHub release with auto-generated notes

Pushes to `ghcr.io/ankimcp/headless-anki:{variant}-{tag}`. The `addons` variant is **not** built in CI (local only).

## Ports

| Port | Service |
|------|---------|
| 5900 | VNC |
| 8765 | AnkiConnect |
| 3141 | Anki MCP Server |

## Addon Handling

Download URL: `https://ankiweb.net/shared/download/{id}?v=2.1&p={version_zero_padded}`

Version is zero-padded with `%02d` per segment: `25.9.4` → `p=250904` (not `2594`).

AnkiConnect (ID `2055492159`) is auto-patched via `jq` to set `webBindAddress` to `0.0.0.0`.

## Gotchas

- `prefs21.db` must exist in variant `data/` dirs — it skips Anki's first-run wizard. Base image does **not** include it.
- `startup.sh` loops `anki -b /data` forever (auto-restart on crash). All variants run as `anki` user except x11-vnc which runs startup as root (needs Xvfb).
- `.gitignore` excludes `*/data/User*/`, `*/data/addons21/`, backups, and `.anki2` files — only `prefs21.db` is tracked.
