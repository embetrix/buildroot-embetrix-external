FROM ubuntu:24.04

ENV USER buildroot
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y software-properties-common

# Set timezone
ENV TZ "Europe/Berlin"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

# Required Packages for the Host Development System
RUN apt-get install -y \
    curl gawk wget git-core git-man git-email diffstat unzip texinfo gcc-multilib \
    g++-multilib zip xz-utils xutils-dev debianutils iputils-ping libsdl1.2-dev xterm \
    build-essential chrpath socat cpio libssl-dev python3 python3-pip python3-pexpect \
    pylint libegl1-mesa libcups2-dev mesa-common-dev libxkbcommon-dev libxkbcommon-x11-dev \
    libwayland-cursor++0 libwayland-cursor0 liblz4-tool libncurses-dev tmux jq nano vim \
    bash-completion zstd file openssh-server openssh-client sudo iproute2 rsync htop

# make /bin/sh symlink to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Create a non-root user that will perform the actual build
RUN id $USER 2>/dev/null || useradd --create-home $USER
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

USER $USER
RUN sudo chown -R $USER:$USER /home/$USER

WORKDIR /home/$USER

CMD ["/bin/bash"]

