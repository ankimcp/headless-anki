FROM python:3.12-slim

ARG ANKI_VERSION=25.9.2

RUN apt update && apt install --no-install-recommends -y \
        curl mpv lame locales unzip \
        # Qt6/xcb dependencies (all libs for both variants)
        libxcb-cursor0 libxcb-xinerama0 libxcb-icccm4 libxcb-image0 \
        libxcb-keysyms1 libxcb-randr0 libxcb-render-util0 libxcb-shape0 \
        libxcb-xfixes0 libxcb-xkb1 libxkbcommon-x11-0 \
        libnss3 libxkbcommon0 libxcomposite1 libxdamage1 libxtst6 libxkbfile1 \
        libegl1 libopengl0 libgl1 libwebpdemux2 libwebpmux3 libminizip1 \
        libfontconfig1 libfreetype6 libx11-xcb1 libxi6 libxrender1 libxrandr2 \
        && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Locale setup
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8 LANGUAGE=en_US LC_ALL=en_US.UTF-8

# Install Anki
RUN uv pip install --system aqt==${ANKI_VERSION}

# Create anki user
RUN useradd -m anki

ENV QMLSCENE_DEVICE=softwarecontext
ENV FONTCONFIG_PATH=/etc/fonts
ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
