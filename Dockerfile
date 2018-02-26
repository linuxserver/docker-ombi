FROM lsiobase/xenial
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
 	libcurl3 \
	libicu55 \
	libunwind8 && \

# install ombi
 mkdir -p /app/ombi && \
 OMBI_VER="$(curl -sX GET https://api.github.com/repos/tidusjar/Ombi/releases/latest | grep 'tag_name' | cut -d\" -f4)" && \
 curl -o \
 /tmp/ombi-src.tar.gz -L \
	"https://github.com/tidusjar/Ombi/releases/download/Ombi-${OMBI_VER}/linux.tar.gz" && \
 tar xzf /tmp/ombi-src.tar.gz -C /app/ombi/ && \
 chmod +x /app/ombi/Ombi && \

# clean up
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3579
VOLUME /config
