# Headless Anki

Minimal headless Anki Docker images. No authentication - just Anki.

## Images

| Directory | Tag | Description |
|-----------|-----|-------------|
| `base/` | `base-vX.X.X` | Base image with Anki + dependencies |
| `qt-vnc/` | `qt-vnc-vX.X.X` | Qt VNC plugin (lightweight) |
| `x11-vnc/` | `x11-vnc-vX.X.X` | X11 + VNC + openbox (full desktop) |
| `x11-vnc-addons/` | `addons-vX.X.X` | X11 + VNC + addon support (local only) |

## Quick Start

```bash
# Pull from GitHub Container Registry
docker pull ghcr.io/ankimcp/headless-anki:x11-vnc-v1.0.0

# Or build locally
cd base && ./run.sh
cd ../x11-vnc && ./run.sh
```

Connect VNC to `localhost:5900`.

## Addons

```bash
cd x11-vnc-addons
docker build --build-arg ADDON_IDS="2055492159" -t headless-anki:addons-v1.0.0 .
docker compose up
```

AnkiConnect (2055492159) is auto-patched to bind to `0.0.0.0` for external access.

## Ports

| Port | Service |
|------|---------|
| 5900 | VNC |
| 8765 | AnkiConnect |
| 3141 | Anki MCP Server |

## Credits

Inspired by [ThisIsntTheWay/headless-anki](https://github.com/ThisIsntTheWay/headless-anki).
