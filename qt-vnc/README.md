# Headless Anki (Qt VNC)

Uses Qt's built-in VNC platform plugin. Lightweight, no window manager.

## Usage

```bash
./run.sh
```

Connect VNC to `localhost:5900`.

## Build Args

- `BASE_TAG` - Base image tag (default: base-v1.0.0)

```bash
docker build --build-arg BASE_TAG=base-v1.0.0 -t headless-anki:qt-vnc-v1.0.0 .
```
