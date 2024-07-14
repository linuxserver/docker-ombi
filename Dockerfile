FROM ghcr.io/linuxserver/baseimage-ubuntu:noble

# set version label
ARG BUILD_DATE
ARG VERSION
ARG OMBI_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

# environment settings
ENV HOME="/config" \
  COMPlus_EnableDiagnostics=0 \
  DEBIAN_FRONTEND="noninteractive" \
  TMPDIR=/run/ombi-temp

RUN \
  apt-get update && \
  apt-get install -y \
    libicu74 && \
  echo "**** install ombi ****" && \
  mkdir -p \
    /app/ombi && \
  if [ -z ${OMBI_RELEASE+x} ]; then \
    OMBI_RELEASE=$(curl -sX GET "https://api.github.com/repos/Ombi-app/Ombi/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
  /tmp/ombi-src.tar.gz -L \
    "https://github.com/Ombi-app/Ombi/releases/download/${OMBI_RELEASE}/linux-x64.tar.gz" && \
  tar xzf /tmp/ombi-src.tar.gz -C \
    /app/ombi/ && \
  chmod +x /app/ombi/Ombi && \
  printf "Linuxserver.io version: ${VERSION}\nBuild-date: ${BUILD_DATE}" > /build_version && \
  echo "**** clean up ****" && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3579
