ARG X11_TAG=x11-vnc-v1.0.0
FROM headless-anki:${X11_TAG}

ARG ANKI_VERSION=25.9.2
ARG ADDON_IDS=""

# Install addons if specified (version format: 25.9.2 -> 250902)
RUN ANKI_VER=$(echo $ANKI_VERSION | awk -F. '{printf "%02d%02d%02d", $1, $2, $3}') && \
    if [ -n "$ADDON_IDS" ]; then \
        for id in $ADDON_IDS; do \
            echo "Installing addon: $id" && \
            curl -sL -o /tmp/$id.zip "https://ankiweb.net/shared/download/$id?v=2.1&p=$ANKI_VER" && \
            mkdir -p /data/addons21/$id && \
            unzip -q /tmp/$id.zip -d /data/addons21/$id/ && \
            rm /tmp/$id.zip && \
            if [ "$id" = "2055492159" ]; then \
                echo "Patching AnkiConnect to bind to all interfaces" && \
                jq '.webBindAddress = "0.0.0.0"' /data/addons21/$id/config.json > /tmp/config.json && \
                mv /tmp/config.json /data/addons21/$id/config.json; \
            fi; \
        done; \
    fi && \
    chown -R anki /data/addons21
