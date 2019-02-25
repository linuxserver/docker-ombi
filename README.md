[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring :-

 * regular and timely application updates
 * easy user mappings (PGID, PUID)
 * custom base image with s6 overlay
 * weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
 * regular security updates

Find us at:
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [IRC](https://irc.linuxserver.io) - on freenode at `#linuxserver.io`. Our primary support channel is Discord.
* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Podcast](https://anchor.fm/linuxserverio) - on hiatus. Coming back soon (late 2018).

# [linuxserver/ombi](https://github.com/linuxserver/docker-ombi)
[![](https://img.shields.io/discord/354974912613449730.svg?logo=discord&label=LSIO%20Discord&style=flat-square)](https://discord.gg/YWrKVTn)
[![](https://images.microbadger.com/badges/version/linuxserver/ombi.svg)](https://microbadger.com/images/linuxserver/ombi "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/linuxserver/ombi.svg)](https://microbadger.com/images/linuxserver/ombi "Get your own version badge on microbadger.com")
![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/ombi.svg)
![Docker Stars](https://img.shields.io/docker/stars/linuxserver/ombi.svg)
[![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Pipeline-Builders/docker-ombi/master)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-ombi/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/ombi/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/ombi/latest/index.html)

[Ombi](https://ombi.io) allows you to host your own Plex Request and user management system.
If you are sharing your Plex server with other users, allow them to request new content using an easy to manage interface!
Manage all your requests for Movies and TV with ease, leave notes for the user and get notification when a user requests something.
Allow your users to post issues against their requests so you know there is a problem with the audio etc.
Even automatically sent them weekly newsletters of new content that has been added to your Plex server!

[![ombi](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/ombi.png)](https://ombi.io)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/). 

Simply pulling `linuxserver/ombi` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v6-latest |


## Usage

Here are some example snippets to help you get started creating a container.

### docker

```
docker create \
  --name=ombi \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Europe/London \
  -p 3579:3579 \
  -v </path/to/appdata/config>:/config \
  --restart unless-stopped \
  linuxserver/ombi
```

Using tags, you can choose between various versions of ombi. No tag is required to remain on the latest stable release.  
Add one of the tags, if required, to the `linuxserver/ombi` line of the run/create command in the following format, `linuxserver/ombi:development`  
The development tag will be the latest commit in the `develop` branch of ombi.  
HOWEVER, USE THE DEVELOPMENT BRANCH AT YOUR OWN PERIL !!!!!!!!!


### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  ombi:
    image: linuxserver/ombi
    container_name: ombi
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Europe/London
    volumes:
      - </path/to/appdata/config>:/config
    ports:
      - 3579:3579
    mem_limit: 4096m
    restart: unless-stopped
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 3579` | web gui |
| `-e PUID=1001` | for UserID - see below for explanation |
| `-e PGID=1001` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London |
| `-v /config` | Contains all relevant configuration files. |

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1001` and `PGID=1001`, to find yours use `id user` as below:

```
  $ id username
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```


&nbsp;
## Application Setup

Access the webui at `<your-ip>:3579`. Follow the setup wizard on initial install.  Then configure the required services.



## Support Info

* Shell access whilst the container is running: `docker exec -it ombi /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f ombi`
* container version number 
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' ombi`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/ombi`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.  
  
Below are the instructions for updating containers:  
  
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/ombi`
* Stop the running container: `docker stop ombi`
* Delete the container: `docker rm ombi`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start ombi`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update the image: `docker-compose pull linuxserver/ombi`
* Let compose update containers as necessary: `docker-compose up -d`
* You can also remove the old dangling images: `docker image prune`

## Versions

* **25.01.19:** - Add info on tags and development builds.
* **17.12.18:** - Switch to multi-arch builds and add aarch64 image.
* **11.03.18:** - Add HOME env to Dockerfile.
* **05.03.18:** - Switch to Ombi v3 stable based on .net core.
* **26.01.18:** - Fix continuation lines.
* **16.04.17:** - Switch to using inhouse mono baseimage.
* **17.02.17:** - Initial Release.
