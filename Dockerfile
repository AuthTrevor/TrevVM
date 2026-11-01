# syntax=docker/dockerfile:1
FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

ARG BUILD_DATE
ARG VERSION
ARG DEBIAN_FRONTEND=noninteractive

LABEL build_version="[Mollomm1 Mod] Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}" \
      maintainer="mollomm1"

COPY root/ /
COPY root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap
COPY root/install-de.sh /install-de.sh

RUN --mount=type=bind,source=.,target=/trevvm-context,readonly \
            set -eux; \
            if [ -f /trevvm-context/options.json ]; then \
                  cp /trevvm-context/options.json /options.json; \
            else \
                  printf '%s\n' '{"defaultapps":[],"programming":[],"apps":[],"enablekvm":true,"DE":"KDE Plasma (Heavy)"}' > /options.json; \
            fi; \
    rm -f /etc/apt/sources.list.d/nodesource.list; \
    apt-get update; \
    apt-get install --no-install-recommends -y software-properties-common; \
    add-apt-repository -y ppa:mozillateam/ppa; \
    apt-get update; \
    apt-get install --no-install-recommends -y firefox jq wget; \
    echo "---- first lines of copied install-de.sh ----"; \
    sed -n '1,5p' /install-de.sh; \
    bash -n /install-de.sh; \
    bash /install-de.sh; \
    chmod +x /installapps.sh; \
    /installapps.sh; \
    rm -f /installapps.sh; \
    apt-get autoclean; \
    apt-get clean; \
    rm -rf \
      /config/.cache \
      /var/lib/apt/lists/* \
      /var/tmp/* \
      /tmp/*

EXPOSE 3000
VOLUME /config
