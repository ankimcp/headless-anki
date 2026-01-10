FROM headless-anki:base-1.0.0

RUN apt update && apt install --no-install-recommends -y \
        xvfb x11vnc openbox \
        && rm -rf /var/lib/apt/lists/*

# Anki data with pre-configured profile (skips first-run wizard)
RUN mkdir -p /data
COPY data/prefs21.db /data/prefs21.db
RUN chown -R anki /data
VOLUME /data

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

ENV DISPLAY=:99
ENV QTWEBENGINE_DISABLE_SANDBOX=1

EXPOSE 5900

CMD ["/startup.sh"]
