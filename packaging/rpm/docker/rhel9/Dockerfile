FROM registry.access.redhat.com/ubi9

# Install required build tools and dependencies
RUN dnf install --setopt=multilib_policy=all -y \
    rpmdevtools \
    make \
    curl-minimal \
    git \
    gcc-c++ \
    glibc-devel \
    libstdc++-devel \
    redhat-rpm-config \
    glibc-static \
    libstdc++-static && \
    dnf clean all

# Copy MCPP spec file into the container
COPY mcpp/packaging/rpm/mcpp.spec /usr/src/mcpp.spec

# Install build dependencies. Do not use dnf builddep as it doesn't obey multilib_policy=all.
RUN rpmspec --parse /usr/src/mcpp.spec 2>/dev/null | \
    grep '^BuildRequires:' | \
    sed -E 's/BuildRequires:\s*//' | \
    tr ',' '\n' | awk '{print $1}' | sort -u > /tmp/dependencies.txt && \
    dnf install --setopt=multilib_policy=all -y $(cat /tmp/dependencies.txt) && \
    rm -f /tmp/dependencies.txt /usr/src/mcpp.spec && \
    dnf clean all

LABEL org.opencontainers.image.source=https://github.com/zeroc-ice/mcpp
LABEL org.opencontainers.image.description="MCPP Red Hat Enterprise Linux 10 Docker image for building RPM packages"
