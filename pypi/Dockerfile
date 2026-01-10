FROM headless-anki:base-1.0.0

# Anki data with pre-configured profile (skips first-run wizard)
RUN mkdir -p /data
COPY data/prefs21.db /data/prefs21.db
RUN chown -R anki /data
VOLUME /data

USER anki

ENV QT_QPA_PLATFORM="offscreen"

CMD ["anki", "-b", "/data"]
