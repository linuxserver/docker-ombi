FROM lsiobase/ubuntu:bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG OMBI_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# environment settings
ENV HOME="/config"

RUN \
 apt-get update && \
 apt-get install -y \
	libcurl3 \
	libicu55 && \
 echo "**** install ombi ****" && \
 mkdir -p \
	/opt/ombi && \
 if [ -z ${OMBI_RELEASE+x} ]; then \
	OMBI_RELEASE=$(curl -sX GET "https://api.github.com/repos/tidusjar/Ombi/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') \
 fi && \
 curl -o \
 /tmp/ombi-src.tar.gz -L \
	"https://github.com/tidusjar/Ombi/releases/download/${OMBI_RELEASE}/linux.tar.gz" && \
 tar xzf /tmp/ombi-src.tar.gz -C \
	/opt/ombi/ && \
 chmod +x /opt/ombi/Ombi && \
 echo "**** clean up ****" && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3579
