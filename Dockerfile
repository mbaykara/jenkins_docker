# This docker image provides all tools used for the development 
# of the Mosaiq Runtime software.

FROM debian:buster-slim as DebianPackages

ARG CONAN_VERSION=1_25_0

RUN mkdir -p /var/debs/
RUN apt-get -q -q update \
    && apt-get -q -q install -y wget \
    && cd /var/debs/ \
    && wget https://dl.bintray.com/conan/installers/conan-ubuntu-64_${CONAN_VERSION}.deb

FROM debian:buster-slim as GitBuild

ARG GIT_VERSION=2.26.2

RUN apt-get -q -q update \
    && apt-get -q -q install -y git clang lld autoconf make curl libcurl4-openssl-dev zlib1g zlib1g-dev openssl expat install-info gettext
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100 \
    && update-alternatives --install /usr/bin/ld ld /usr/bin/lld 100 \
    && update-alternatives --config cc \
    && update-alternatives --config c++ \
    && update-alternatives --config ld
RUN cd /tmp/ \
    && git clone https://github.com/git/git.git --branch="v${GIT_VERSION}"
RUN cd /tmp/git \
    && make configure \
    && ./configure --prefix=/usr/local \
    && make -j16 \
    && make install


FROM debian:buster-slim as NinjaBuild

ARG NINJA_VERSION=1.10.0

COPY --from=GitBuild /usr/local/ /usr/local/

RUN apt-get -q -q update \
    && apt-get -q -q install -y clang lld libcurl4-openssl-dev openssl python3
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100 \
    && update-alternatives --install /usr/bin/ld ld /usr/bin/lld 100 \
    && update-alternatives --config cc \
    && update-alternatives --config c++ \
    && update-alternatives --config ld
RUN mkdir -p /tmp/ && cd /tmp/ \
    && git clone https://github.com/ninja-build/ninja.git --branch="v${NINJA_VERSION}"
RUN cd /tmp/ninja/ \
    && CXX=clang++ ./configure.py --bootstrap


FROM debian:buster-slim as CMakeBuild

ARG CMAKE_VERSION=3.17.2

COPY --from=GitBuild /usr/local/ /usr/local/

RUN apt-get -q -q update \
    && apt-get -q -q install -y clang lld make libcurl4-openssl-dev libssl-dev openssl
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100 \
    && update-alternatives --install /usr/bin/ld ld /usr/bin/lld 100 \
    && update-alternatives --config cc \
    && update-alternatives --config c++ \
    && update-alternatives --config ld
RUN mkdir -p /tmp/cmake-prebuild/ \
    && cd /tmp/ \
    && git clone https://gitlab.kitware.com/cmake/cmake.git --branch="v${CMAKE_VERSION}"
RUN cd /tmp/cmake \
    && ./bootstrap --prefix=/tmp/cmake-prebuild \
    && make -j16 \
    && make install


FROM debian:buster-slim as CcacheBuild

ARG CCACHE_VERSION=3.7.9

COPY --from=GitBuild /usr/local/ /usr/local/

RUN apt-get -q -q update \
    && apt-get -q -q install -y \
    clang lld make autogen autoconf gperf asciidoc xsltproc libcurl4-openssl-dev
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100 \
    && update-alternatives --install /usr/bin/ld ld /usr/bin/lld 100 \
    && update-alternatives --config cc \
    && update-alternatives --config c++ \
    && update-alternatives --config ld
RUN mkdir -p /tmp/ccache-prebuild/ \
    && cd /tmp/ \
    && git clone https://github.com/ccache/ccache.git --branch="v${CCACHE_VERSION}"
RUN cd /tmp/ccache \
    && ./autogen.sh \
    && ./configure --with-libb2-from-internet --with-libzstd-from-internet --prefix=/tmp/ccache-prebuild \
    && make -j16 \
    && make install


FROM debian:buster-slim as LlvmBuild

ARG LLVM_VERSION=10.0.0

COPY --from=GitBuild /usr/local/ /usr/local/
COPY --from=NinjaBuild /tmp/ninja/ninja /usr/local/bin/
COPY --from=CMakeBuild /tmp/cmake-prebuild/ /usr/local/

RUN apt-get -q -q update \
    && apt-get -q -q install -y clang lld openssl libcurl4-openssl-dev
RUN mkdir -p /tmp/llvm-prebuild/ \
    && cd /tmp/ \
    && git clone https://github.com/llvm/llvm-project.git --branch="llvmorg-${LLVM_VERSION}"
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100 \
    && update-alternatives --install /usr/bin/ld ld /usr/bin/lld 100 \
    && update-alternatives --config cc \
    && update-alternatives --config c++ \
    && update-alternatives --config ld
RUN mkdir -p /tmp/build \
    && cd /tmp/build \
    && cmake -G "Ninja" \
             -DCMAKE_INSTALL_PREFIX=/tmp/llvm-prebuild \
             -DCMAKE_BUILD_TYPE=Release \
             -DLLVM_TARGETS_TO_BUILD="AArch64;ARM;X86" \
             -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;libcxx;libcxxabi;libunwind;lldb;compiler-rt;lld;polly"  \
             /tmp/llvm-project/llvm \
    && cmake --build . \
    && cmake --build . --target install


FROM debian:buster-slim
LABEL maintainer="encoway GmbH - New Automation Technologies"
LABEL Description="MOSAIQ Runtime development tooling environment"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

COPY --from=DebianPackages /var/debs/ /tmp/debs/
COPY --from=GitBuild /usr/local/ /usr/local/
COPY --from=NinjaBuild /tmp/ninja/ninja /usr/local/bin/
COPY --from=CMakeBuild /tmp/cmake-prebuild/ /usr/local/
COPY --from=CcacheBuild /tmp/ccache-prebuild/ /usr/local/
COPY --from=LlvmBuild /tmp/llvm-prebuild/ /usr/local/

RUN apt-get -q -q update \
    && apt-get -q -q install -y \
        curl \
        libncurses6 \
        libcurl4-openssl-dev \
        openssl \
        python3 \
        python3-pip \
        vera++ \
        cppcheck \
        /tmp/debs/* \
    && rm -rf /tmp/debs

RUN pip3 install lizard \
    && pip3 install cmake_format

RUN update-alternatives --install /usr/bin/cc cc /usr/local/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/local/bin/clang++ 100 \
    && update-alternatives --install /usr/bin/ld ld /usr/local/bin/lld 100 \
    && update-alternatives --config cc \
    && update-alternatives --config c++ \
    && update-alternatives --config ld
    
ARG user=jenkins
ARG group=jenkins
ARG uid=1003
ARG gid=1003
ARG JENKINS_AGENT_HOME=/tmp/${user}
ARG CONAN_USER_HOME=/tmp/
ARG CONAN_USER_HOME_SHORT=/tmp/

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN groupadd -g ${gid} ${group} && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"
