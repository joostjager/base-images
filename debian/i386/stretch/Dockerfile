FROM i386/debian:stretch-slim

LABEL io.resin.architecture="i386"

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive




RUN apt-get update && apt-get install -y --no-install-recommends \
		sudo \
		ca-certificates \
		findutils \
		gnupg \
		dirmngr \
	&& rm -rf /var/lib/apt/lists/*

COPY 01_nodoc /etc/dpkg/dpkg.cfg.d/
COPY 01_buildconfig /etc/apt/apt.conf.d/
# Install Systemd

RUN apt-get update && apt-get install -y --no-install-recommends \
		systemd \
	&& rm -rf /var/lib/apt/lists/*

ENV container docker

# We never want these to run in a container
RUN systemctl mask \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \

    display-manager.service \
    getty@.service \
    systemd-logind.service \
    systemd-remount-fs.service \

    getty.target \
    graphical.target  

COPY entry.sh /usr/bin/entry.sh    
COPY launch.service /etc/systemd/system/launch.service

RUN systemctl enable /etc/systemd/system/launch.service

STOPSIGNAL 37
VOLUME ["/sys/fs/cgroup"]
ENTRYPOINT ["/usr/bin/entry.sh"]