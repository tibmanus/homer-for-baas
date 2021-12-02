# syntax=docker/dockerfile:1
FROM b4bz/homer:latest

# install envsubst
RUN mkdir -p /usr/local/sbin \
    && cd /usr/local/sbin \
    && apk add --update gettext libintl \
    && mv /usr/bin/envsubst /usr/local/sbin/envsubst

RUN addgroup -g 65532 nonroot \
    && adduser -u 65532 -s /bin/false -D -G nonroot nonroot \
    && mkdir -p /config && chown -R nonroot:nonroot /config \
    && chown -R nonroot:nonroot /www

USER nonroot

COPY --chown=65532:65532 entrypoint.sh /entrypoint.sh

CMD ["/bin/sh", "-c", "/entrypoint.sh"]
