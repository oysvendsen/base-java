FROM quay.io/evryfs/base-ubuntu:bionic-20200219
LABEL maintainer "David J. M. Karlsen <david@davidkarlsen.com>"
ARG JDK_VERSION=13.0.2+8
ARG DOWNLOAD_URL=https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jdk_x64_linux_hotspot_13.0.2_8.tar.gz
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN	mkdir -p /usr/lib/jvm && \
	curl -Ls ${DOWNLOAD_URL} | tar xzv -C /usr/lib/jvm && \
	sh -c 'for bin in /usr/lib/jvm/jdk-${JDK_VERSION}/bin/*; do update-alternatives --install /usr/bin/$(basename $bin) $(basename $bin) $bin 100 ;done' && \
	sh -c 'for bin in /usr/lib/jvm/jdk-${JDK_VERSION}/bin/*; do update-alternatives --set $(basename $bin) $bin; done' && \
	java -Xshare:dump
