FROM ubuntu:24.04

ENV USER=buildroot
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y software-properties-common

# Set timezone
ENV TZ="Europe/Berlin"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ > /etc/timezone

# Required Packages for the Host Development System
RUN apt-get install --no-install-recommends --fix-missing -y \
    curl gawk wget git-core git-man git-email diffstat unzip texinfo  \
    gcc-multilib g++-multilib zip xz-utils xutils-dev debianutils iputils-ping xterm \
    build-essential chrpath socat bc cpio libssl-dev libncurses-dev \
    python3 python3-pip python3-pexpect  \
    pylint liblz4-tool nano vim strace qemu-user qemu-user-static sbsigntool \
    bash-completion zstd file openssh-server openssh-client sudo iproute2 rsync htop \
    bison flex xxd bsdmainutils

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

