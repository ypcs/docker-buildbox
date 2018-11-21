FROM ypcs/ubuntu:bionic

RUN sed 's/^deb /deb-src /g' /etc/apt/sources.list |tee -a /etc/apt/sources.list && \
    sed -i 's/main$/main universe/g' /etc/apt/sources.list && \
    /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get --assume-yes install \
        build-essential \
        devscripts \
        git \
        gosu && \
    /usr/lib/docker-helpers/apt-cleanup

RUN mkdir -p /artifacts

RUN adduser --disabled-password --gecos "build,,," build && \
    adduser build src && \
    chgrp src /artifacts && \
    chmod g+w /artifacts && \
    chgrp src /usr/src && \
    chmod g+w /usr/src

WORKDIR /usr/src

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
