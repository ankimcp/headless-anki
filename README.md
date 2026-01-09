# Headless Anki

Minimal headless Anki Docker image. No plugins, no authentication - just Anki running in offscreen mode.

## Usage

```bash
docker run -d -v $(pwd)/data:/data headless-anki:latest
```

With VNC for debugging:
```bash
docker run -d -p 5900:5900 -e QT_QPA_PLATFORM="vnc" headless-anki:latest
```

## Building

```bash
docker build -t headless-anki:latest .

# Specific Anki version
docker build --build-arg ANKI_VERSION=25.02.7 --build-arg QT_VERSION=6 -t headless-anki:latest .
```

## Volumes

- `/data` - Anki data directory (profiles, collections)

## Environment Variables

- `QT_QPA_PLATFORM` - Qt platform plugin (default: `offscreen`, use `vnc` for VNC access on port 5900)

## Credits

Inspired by [ThisIsntTheWay/headless-anki](https://github.com/ThisIsntTheWay/headless-anki) which includes AnkiConnect plugin and additional features.
