FROM golang:1.16.3-buster as stratum-ping-builder

RUN mkdir -p /home/docker; \
    cd /home/docker; \
    git clone https://github.com/2miners/stratum-ping --depth 1; \
    cd stratum-ping; \
    go build main.go;

FROM debian:latest

COPY --from=stratum-ping-builder /home/docker/stratum-ping/main /home/docker/stratum-ping
COPY latencytest.sh /home/docker/latencytest.sh
RUN chmod +x /home/docker/latencytest.sh
WORKDIR /home/docker

CMD ["./latencytest.sh"] 

