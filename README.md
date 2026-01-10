# Headless Anki

Minimal headless Anki Docker images. No authentication - just Anki.

## Images

| Image | Tag | Description |
|-------|-----|-------------|
| `base/` | `headless-anki:base-1.0.0` | Base image with Anki + dependencies |
| `pypi/` | `headless-anki:pypi-1.0.0` | Offscreen mode |
| `pypi-x11/` | `headless-anki:x11-1.0.0` | X11 + VNC + openbox |
| `pypi-x11-addons/` | `headless-anki:addons-1.0.0` | X11 + VNC + addon support |

## Quick Start

```bash
# Build base first
cd base && ./run.sh

# Then build and run variant
cd ../pypi-x11 && ./run.sh
```

Connect VNC to `localhost:5900`.

## Addons

```bash
cd pypi-x11-addons
# Edit ADDON_IDS in run-addon.sh
./run-addon.sh
```

## Credits

Inspired by [ThisIsntTheWay/headless-anki](https://github.com/ThisIsntTheWay/headless-anki).
