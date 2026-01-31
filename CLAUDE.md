# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Minimal headless Anki Docker images using PyPI (`aqt` package). No authentication - just Anki in a container.

## Architecture

Image inheritance chain (build order matters):
```
base → qt-vnc → qt-vnc-addons
     → x11-vnc → x11-vnc-addons
```

| Directory | Tag | Mode |
|-----------|-----|------|
| `base/` | `base-vX.X.X` | Base only (no CMD) |
| `qt-vnc/` | `qt-vnc-vX.X.X` | `QT_QPA_PLATFORM=vnc` (lightweight) |
| `qt-vnc-addons/` | `qt-vnc-addons-vX.X.X` | Qt VNC + addons at build |
| `x11-vnc/` | `x11-vnc-vX.X.X` | Xvfb + openbox + x11vnc (full desktop) |
| `x11-vnc-addons/` | `x11-vnc-addons-vX.X.X` | X11 VNC + addons at build |

## Releases

Push a git tag to trigger CI build and GitHub release:
```bash
git tag v1.0.0 && git push origin v1.0.0
```

This builds and pushes to ghcr.io:
- `ghcr.io/ankimcp/headless-anki:base-v1.0.0`
- `ghcr.io/ankimcp/headless-anki:qt-vnc-v1.0.0`
- `ghcr.io/ankimcp/headless-anki:x11-vnc-v1.0.0`
- `ghcr.io/ankimcp/headless-anki:qt-vnc-addons-v1.0.0`
- `ghcr.io/ankimcp/headless-anki:x11-vnc-addons-v1.0.0`

## Local Development

```bash
# Build base first (required)
cd base && ./run.sh

# Build and run a variant
cd x11-vnc && ./run.sh

# Build with addons (addon IDs configured in run.sh)
cd qt-vnc-addons && ./run.sh
# or
cd x11-vnc-addons && ./run.sh
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

## Version Bumping

Version `v1.0.0` is hardcoded in multiple places — when bumping, update all of:
- `base/run.sh`, `qt-vnc/run.sh`, `x11-vnc/run.sh`, `qt-vnc-addons/run.sh`, `x11-vnc-addons/run.sh`
- `ARG BASE_TAG` in `qt-vnc/Dockerfile` and `x11-vnc/Dockerfile`
- `ARG QT_VNC_TAG` in `qt-vnc-addons/Dockerfile`
- `ARG X11_TAG` in `x11-vnc-addons/Dockerfile`

CI (`docker.yaml`) derives versions from the git tag automatically, so only local scripts need manual updates.

## CI Notes

- Triggered on `v*` tags only
- Builds multi-platform: `linux/amd64` + `linux/arm64` (via QEMU)
- `build-base` runs first, then `build-variants` (qt-vnc, x11-vnc) in parallel, then `build-addons` (qt-vnc-addons, x11-vnc-addons) in parallel

## Gotcha: Addon Version Format

The `*-addons/Dockerfile`s format version as `%02d%02d%02d` (e.g., 25.9.2 → `250902`), which differs from the simpler format in the download URL docs above (`2592`). The Dockerfile format is the correct one used at build time.
