FROM alpine:3.22.1 AS build

LABEL org.opencontainers.image.authors="The OpenList Team" \
    org.opencontainers.image.base.name="docker.io/openlistteam/openlist-aria2-standalone:1.37.0" \
    org.opencontainers.image.description="Aria2 Standalone" \
    org.opencontainers.image.documentation="https://hub.docker.com/openlistteam/openlist-aria2-standalone/" \
    org.opencontainers.image.licenses="AGPL-3.0" \
    org.opencontainers.image.ref.name="1.37.0" \
    org.opencontainers.image.source="https://github.com/OpenListTeam/OpenList-Aria2-Standalone" \
    org.opencontainers.image.title="Aria2 Standalone" \
    org.opencontainers.image.url="https://github.com/OpenListTeam/OpenList-Aria2-Standalone" \
    org.opencontainers.image.vendor="The OpenList Team" \
    org.opencontainers.image.version="1.37.0"

RUN apk add --no-cache build-base openssl-dev ca-certificates wget libxml2-dev sqlite-dev zlib-dev c-ares-dev pkgconf
RUN wget -O /tmp/aria2-1.37.0.tar.gz https://github.com/aria2/aria2/releases/download/release-1.37.0/aria2-1.37.0.tar.gz
RUN tar -xzf /tmp/aria2-1.37.0.tar.gz -C /tmp
RUN cd /tmp/aria2-1.37.0 && \
    ./configure --prefix=/opt/aria2 --with-openssl --without-gnutls --without-libnettle --without-libgmp --without-libexpat --without-libssh2 --with-ca-bundle='/etc/ssl/certs/ca-certificates.crt' && \
    make -j$(nproc) && \
    make install

FROM alpine:3.22.1

LABEL org.opencontainers.image.authors="The OpenList Team" \
    org.opencontainers.image.base.name="docker.io/openlistteam/openlist-aria2-standalone:1.37.0" \
    org.opencontainers.image.description="Aria2 Standalone" \
    org.opencontainers.image.documentation="https://hub.docker.com/openlistteam/openlist-aria2-standalone/" \
    org.opencontainers.image.licenses="AGPL-3.0" \
    org.opencontainers.image.ref.name="1.37.0" \
    org.opencontainers.image.source="https://github.com/OpenListTeam/OpenList-Aria2-Standalone" \
    org.opencontainers.image.title="Aria2 Standalone" \
    org.opencontainers.image.url="https://github.com/OpenListTeam/OpenList-Aria2-Standalone" \
    org.opencontainers.image.vendor="The OpenList Team" \
    org.opencontainers.image.version="1.37.0"

RUN apk add --no-cache ca-certificates zlib sqlite-libs libxml2 c-ares libstdc++ libgcc

COPY --from=build /opt/aria2 /opt/aria2
COPY ./aria2.conf /opt/aria2/aria2.conf
COPY ./entrypoint.sh /entrypoint.sh

RUN addgroup -g 1001 aria2 && \
    adduser -D -u 1001 -G aria2 aria2 && \
    mkdir -p /opt/aria2/downloads && \
    touch /opt/aria2/aria2.session && \
    chown -R aria2:aria2 /opt/aria2 && \
    chmod -R 755 /opt/aria2 && \
    chmod +x /opt/aria2/bin/aria2c && \
    chmod +x /entrypoint.sh

ENV RPC_LISTEN_PORT=6800 \
    RPC_SECRET=123456 \
    RPC_SECURE=false \
    RPC_CERTIFICATE=/opt/aria2/aria2.crt \
    RPC_PRIVATE_KEY=/opt/aria2/aria2.key

USER 1001:1001

ENTRYPOINT ["/entrypoint.sh"]
