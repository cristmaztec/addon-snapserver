ARG BUILD_FROM=ghcr.io/hassio-addons/base:16.3.2
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies
RUN \
    apk add --no-cache \
        pulseaudio \
        alsa-plugins-pulse \
        bash \
    && rm -fr \
        /tmp/*

# Install Librespot
RUN \
    apk add --no-cache \
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
        librespot

# Install Snapcast
RUN \
    apk add --no-cache \
        --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
        snapcast-server=0.31.0-r0

# Install Snapweb
RUN \
    wget https://github.com/badaix/snapweb/releases/download/v0.8.0/snapweb.zip && \
    unzip -o snapweb.zip -d /usr/share/snapserver/snapweb/ && \
    rm snapweb.zip

# Copy data for add-on
COPY run.sh /

RUN chmod a+x /run.sh

CMD ["/run.sh"]
