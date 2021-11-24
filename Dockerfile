# syntax=docker/dockerfile:1
FROM b4bz/homer:latest

# install envsubst
RUN mkdir -p /usr/local/sbin \
    && cd /usr/local/sbin \
    && apk add --update gettext libintl \
    && mv /usr/bin/envsubst /usr/local/sbin/envsubst 

ENV USER homer
ENV UID 8000
ENV GROUP homer
ENV GID 8000

RUN addgroup -S ${GROUP} -g ${GID} && adduser -D -S -u ${UID} ${USER} ${GROUP}
RUN mkdir /config && touch /config/config-sub.yml && ln -s /config/config-sub.yml /www/assets/config.yml && chown ${USER}:${GROUP} /config/config-sub.yml

USER homer

COPY --chown=homer entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh"]