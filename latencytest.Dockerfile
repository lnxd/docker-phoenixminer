FROM golang:1.16.3-buster AS stratum-ping-builder

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

RUN mkdir -p /home/docker; \
    cd /home/docker; \
    git clone https://github.com/2miners/stratum-ping --depth 1; \
    cd stratum-ping; \
    go build main.go;

FROM debian:latest AS jq-builder

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

# get dependencies and build.
# valgrind seems to have trouble with pthreads TLS so it's off.

RUN apt-get update; \
    apt-get install -y build-essential autoconf libtool git bison flex python3 python3-pip wget; \
    git clone --depth 1 https://github.com/stedolan/jq /app; \
    pip3 install pipenv; \
    (cd /app/docs && pipenv sync) && \
    (cd /app && \
        git submodule init && \
        git submodule update && \
        autoreconf -i && \
        ./configure --disable-valgrind --enable-all-static --prefix=/usr/local && \
        make -j8 && \
        make check && \
        make install ) && \
    (cd /app/modules/oniguruma && \
        make uninstall ) && \
    (cd /app && \
        make distclean );

FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

COPY --from=stratum-ping-builder /home/docker/stratum-ping/main /home/docker/stratum-ping
COPY --from=jq-builder /usr/local/bin/jq /home/docker/jq
COPY latencytest.sh /home/docker/latencytest.sh
RUN chmod +x /home/docker/latencytest.sh
WORKDIR /home/docker

CMD ["./latencytest.sh"] 

