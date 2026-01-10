FROM headless-anki:base-1.0.0

ARG ANKI_VERSION=25.9.2
ARG ADDON_IDS=""

RUN apt update && apt install --no-install-recommends -y \
        xvfb x11vnc openbox \
        && rm -rf /var/lib/apt/lists/*

# Anki data with pre-configured profile
RUN mkdir -p /data/addons21
COPY data/prefs21.db /data/prefs21.db

# Install addons if specified (version format: 25.9.2 -> 250902)
RUN ANKI_VER=$(echo $ANKI_VERSION | tr -d '.') && \
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
    fi

RUN chown -R anki /data
VOLUME /data

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

ENV DISPLAY=:99
ENV QTWEBENGINE_DISABLE_SANDBOX=1

EXPOSE 5900

CMD ["/startup.sh"]
