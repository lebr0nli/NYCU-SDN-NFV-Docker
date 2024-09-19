FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    bzip2 \
    curl \
    git \
    maven \
    python2 \
    python3 \
    unzip \
    zip \
    tar \
    xz-utils \
    wget \
    arping \
    git \
    iputils-ping \
    sudo \
    vim \
    ssh \
    openssh-server \
    openssh-client \
    kmod && \
    rm -rf /var/lib/apt/lists/*

ARG BAZELISK_VERSION=1.12.0
ARG ONOS_VERSION=2.7.0
ARG MININET_VERSION=2.3.0
ARG OVS_VERSION=2.17.2

# Install Bazelisk
RUN wget "https://github.com/bazelbuild/bazelisk/releases/download/v${BAZELISK_VERSION}/bazelisk-linux-amd64" && \
    mv bazelisk-linux-amd64 /usr/local/bin/bazel && \
    chmod +x /usr/local/bin/bazel

# Install ONOS
RUN git clone --branch ${ONOS_VERSION} --depth 1 https://gerrit.onosproject.org/onos ~/onos && \
    cd ~/onos && \
    ln -sf python2 /usr/bin/python && \
    bazel build onos && \
    mkdir -p ~/.ssh && \
    echo 'Host localhost\nHostkeyAlgorithms +ssh-rsa\nPubkeyAcceptedAlgorithms +ssh-rsa' >> ~/.ssh/config && \
    echo "export ONOS_ROOT=~/onos\n. \${ONOS_ROOT}/tools/dev/bash_profile" >> ~/.bashrc

# Install Mininet
RUN git clone --branch ${MININET_VERSION} --depth 1 https://github.com/mininet/mininet.git ~/mininet && \
    cd ~/mininet && \
    apt-get update && \
    PYTHON=python3 ~/mininet/util/install.sh -n && \
    rm -rf /var/lib/apt/lists/*

# Install Open vSwitch (OVS)
RUN wget "https://www.openvswitch.org/releases/openvswitch-${OVS_VERSION}.tar.gz" && \
    tar -xf openvswitch-${OVS_VERSION}.tar.gz && \
    rm openvswitch-${OVS_VERSION}.tar.gz && \
    mv openvswitch-${OVS_VERSION} ~/ovs && \
    cd ~/ovs && \
    ./configure && \
    make && \
    make install
