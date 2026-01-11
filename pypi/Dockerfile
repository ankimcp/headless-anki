FROM headless-anki:base-1.0.0

# Anki data with pre-configured profile (skips first-run wizard)
RUN mkdir -p /data
COPY data/prefs21.db /data/prefs21.db
RUN chown -R anki /data
VOLUME /data

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

USER anki

ENV QT_QPA_PLATFORM="offscreen"

CMD ["/startup.sh"]
