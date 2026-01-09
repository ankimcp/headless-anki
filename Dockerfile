FROM ubuntu:22.04

ARG ANKI_VERSION=25.02.7
ARG QT_VERSION=6

RUN apt update && apt install --no-install-recommends -y \
        wget zstd mpv locales libxcb-xinerama0 libxcb-cursor0 libnss3 \
        libxcomposite-dev libxdamage-dev libxtst-dev libxkbcommon-dev libxkbfile-dev \
        && rm -rf /var/lib/apt/lists/*

# Create anki user
RUN useradd -m anki

# Anki installation
RUN mkdir /app && chown -R anki /app
WORKDIR /app

RUN wget -O ANKI.tar.zst --no-check-certificate https://github.com/ankitects/anki/releases/download/${ANKI_VERSION}/anki-${ANKI_VERSION}-linux-qt${QT_VERSION}.tar.zst && \
    zstd -d ANKI.tar.zst && rm ANKI.tar.zst && \
    tar xfv ANKI.tar && rm ANKI.tar
WORKDIR /app/anki-${ANKI_VERSION}-linux-qt${QT_VERSION}

# Run modified install.sh (skip xdg-mime registration)
RUN cat install.sh | sed 's/xdg-mime/#/' | sh -

# Locale setup
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US LC_ALL=en_US.UTF-8

# Anki data volume
RUN mkdir /data && chown -R anki /data
VOLUME /data

USER anki

ENV QMLSCENE_DEVICE=softwarecontext
ENV FONTCONFIG_PATH=/etc/fonts
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
ENV QT_QPA_PLATFORM="offscreen"

CMD ["anki", "-b", "/data"]
