FROM lsiobase/mono
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install ombi
RUN \
 mkdir -p \
	/opt && \
 ombi_tag=$(curl -sX GET "https://api.github.com/repos/tidusjar/Ombi/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/ombi-src.zip -L \
	"https://github.com/tidusjar/Ombi/releases/download/${ombi_tag}/Ombi.zip" && \
 unzip -q /tmp/ombi-src.zip -d /tmp && \
 mv /tmp/Release /opt/ombi && \

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
