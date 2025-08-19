#!/bin/sh
set -e
# build aria2 from source in ubuntu (github actions ubuntu-latest)
# RUN apk add --no-cache build-base openssl-dev ca-certificates wget libxml2-dev sqlite-dev zlib-dev c-ares-dev pkgconf
# RUN wget -O /tmp/aria2-${ARIA2_VERSION}.tar.gz https://github.com/aria2/aria2/releases/download/release-${ARIA2_VERSION}/aria2-${ARIA2_VERSION}.tar.gz
# RUN tar -xzf /tmp/aria2-${ARIA2_VERSION}.tar.gz -C /tmp
# RUN cd /tmp/aria2-${ARIA2_VERSION} && \
#     ./configure --prefix=/opt/aria2 --with-openssl --without-gnutls --without-libnettle --without-libgmp --without-libexpat --without-libssh2 --with-ca-bundle='/etc/ssl/certs/ca-certificates.crt' && \
#     make -j$(nproc) && \
#     make install
if [ -z "$ARIA2_VERSION" ]; then
  echo "Please set ARIA2_VERSION environment variable."
  exit 1
fi
apt update
apt install -y build-essential libssl-dev libxml2-dev libsqlite3-dev zlib1-dev libc-ares-dev pkgconf wget
mkdir -p aria2/build
mkdir -p /tmp
wget -O /tmp/aria2-${ARIA2_VERSION}.tar.gz
cd /tmp
tar -xzf /tmp/aria2-${ARIA2_VERSION}.tar.gz
cd /tmp/aria2-${ARIA2_VERSION}
./configure --prefix=aria2/build --with-openssl --without-gnutls --without-libnettle --without-libgmp --without-libexpat --without-libssh2 --with-ca-bundle='/etc/ssl/certs/ca-certificates.crt'
make -j$(nproc)
make install
echo "Aria2 version $(aria2/build/bin/aria2c --version | head -n 1) "
rm -rf /tmp/aria2-${ARIA2_VERSION} /tmp/aria2-${ARIA2_VERSION}.tar.gz