# CLAUDE.md

## Project Overview

Minimal headless Anki Docker images using PyPI (`aqt` package).

## Architecture

All variants extend `headless-anki:base-1.0.0`:
- `base/` - Python 3.12 + uv + Anki + all Qt/X11 libs
- `pypi/` - Offscreen mode (`QT_QPA_PLATFORM=offscreen`)
- `pypi-x11/` - Xvfb + openbox + x11vnc
- `pypi-x11-addons/` - Same + addon installation via `ADDON_IDS` build arg

## Commands

```bash
# Build base (required first)
cd base && ./run.sh

# Build and run variant
cd pypi-x11 && ./run.sh

# Build with addons
cd pypi-x11-addons && ./run-addon.sh
```

## Key Files

- `base/Dockerfile` - Base image, no prefs21.db
- `*/data/prefs21.db` - Pre-configured profile (skips first-run wizard)
- `*/startup.sh` - X11 startup script

## Addon Download URL

```
https://ankiweb.net/shared/download/{id}?v=2.1&p={version_no_dots}
```
Example: version 25.9.2 → `p=2592`
