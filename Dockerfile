FROM lsiobase/xenial

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 apt-get update && \
 apt-get install -y \
 	libcurl3 \
	libicu55 \
	libunwind8 && \
 echo "**** install ombi ****" && \
 mkdir -p \
	/opt/ombi && \
 ombi_tag=$(curl -sX GET "https://api.github.com/repos/tidusjar/Ombi/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/ombi-src.tar.gz -L \
	"https://github.com/tidusjar/Ombi/releases/download/${ombi_tag}/linux.tar.gz" && \
 tar xzf /tmp/ombi-src.tar.gz -C /opt/ombi/ && \
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
VOLUME /config
