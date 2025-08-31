FROM bmoorman/ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive \
    GEYSER_PORT=19132/udp

# Create the labels
ARG DATE
ARG DESCRIPTION
ARG LICENSE="GPL-3.0-or-later"
ARG MAINTAINER
ARG NAME
ARG SOURCE="${WEBSITE}"
ARG TITLE
ARG VERSION
ARG VENDOR="${MAINTAINER}"
ARG WEBSITE

LABEL maintainer="${MAINTAINER}"
LABEL org.opencontainers.image.created="${DATE}"
LABEL org.opencontainers.image.description="${DESCRIPTION}"
LABEL org.opencontainers.image.licenses="${LICENSE}"
LABEL org.opencontainers.image.name="${NAME}"
LABEL org.opencontainers.image.source="${SOURCE}"
LABEL org.opencontainers.image.title="${TITLE}"
LABEL org.opencontainers.image.url="${WEBSITE}"
LABEL org.opencontainers.image.vendor="${VENDOR}"
LABEL org.opencontainers.image.version="${VERSION}"

WORKDIR /var/lib/geyser

RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
    openjdk-21-jre-headless \
    vim \
    wget \
 && mkdir -p /opt/geyser \
 && wget --quiet --output-document "/opt/geyser/Geyser-Standalone.jar" "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/standalone" \
 && apt-get autoremove --yes --purge \
 && apt-get clean \
 && rm --recursive --force /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY geyser/ /etc/geyser/

VOLUME /var/lib/geyser

EXPOSE ${GEYSER_PORT}

CMD ["/etc/geyser/start.sh"]
