FROM ghcr.io/goreleaser/goreleaser-cross:v1.20.2

ARG CHOCOLATEY_VERSION=1.3.1

# Install mono
RUN apt-get update
RUN apt-get install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN apt-add-repository 'deb https://download.mono-project.com/repo/ubuntu stable-focal main'
RUN apt-get install -y mono-complete

# Install Chocolatey
RUN apt-get install -y wget
RUN mkdir -p /opt/chocolatey
RUN wget -q -O - "https://github.com/chocolatey/choco/releases/download/${CHOCOLATEY_VERSION}/chocolatey.v${CHOCOLATEY_VERSION}.tar.gz" | tar -xz -C "/opt/chocolatey"
RUN echo '#!/bin/bash' >> /usr/local/bin/choco
RUN echo 'mono /opt/chocolatey/choco.exe $@' >> /usr/local/bin/choco
RUN chmod +x /usr/local/bin/choco