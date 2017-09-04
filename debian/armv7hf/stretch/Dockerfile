FROM arm32v7/debian:stretch-slim

LABEL io.resin.architecture="armv7hf" io.resin.qemu.version="2.9.0.resin1-arm"

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

COPY qemu-arm-static /usr/bin/

# Resin-xbuild
COPY resin-xbuild /usr/bin/
RUN ln -s resin-xbuild /usr/bin/cross-build-start \
	&& ln -s resin-xbuild /usr/bin/cross-build-end

