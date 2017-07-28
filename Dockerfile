FROM lsiobase/xenial
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# environment variables
ARG DEBIAN_FRONTEND="noninteractive"
ENV ASPNETCORE_URLS="http://*:3579"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	apt-transport-https \
	unzip && \
 apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 417A0893 && \
 echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet-release/ xenial main" > \
	/etc/apt/sources.list.d/dotnetdev.list && \
 apt-get update && \
 apt-get install -y \
	dotnet-sharedframework-microsoft.netcore.app-1.1.2 \
	sqlite3 && \

# install ombi
 curl -o \
 /tmp/ombi-src.zip -L \
	"https://ci.appveyor.com/api/buildjobs/c4b50mc92h2qx72i/artifacts/Ombi_ubuntu.zip" && \
 unzip -q /tmp/ombi-src.zip -d /tmp && \
 mv /tmp/publish /app/ombi && \

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
