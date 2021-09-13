ARG BASE

FROM ubuntu:${BASE:-20.04}

# Install default apps
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y apt-utils; \
    apt-get install -y curl sudo libpci3 xz-utils wget kmod; \
# Clean up apt
    apt-get clean all; \
# Set timezone
    ln -fs /usr/share/zoneinfo/Australia/Melbourne /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata; \
# Prevent error messages when running sudo
    echo "Set disable_coredump false" >> /etc/sudo.conf; \
# Create user account
    useradd docker; \
    groupadd -g 98 docker; \
    useradd --uid 99 --gid 98 docker; \
    echo 'docker:docker' | chpasswd; \
    usermod -aG sudo docker; \
    mkdir -p /home/docker;

# Get Phoenix Miner
ARG MINERV=5.7b
ENV MINERV=$MINERV
RUN curl "https://phoenixminer.info/downloads/PhoenixMiner_${MINERV}_Linux.tar.gz" -L -o "PhoenixMiner_${MINERV}_Linux.tar.gz"; \
    tar xvzf PhoenixMiner_${MINERV}_Linux.tar.gz -C /home/docker; \
    mv "/home/docker/PhoenixMiner_${MINERV}_Linux" "/home/docker/phoenixminer"; \
    sudo chmod +x /home/docker/phoenixminer/PhoenixMiner;

# Copy latest scripts
COPY start.sh mine.sh custom-mine.sh /home/docker/
RUN chmod +x /home/docker/start.sh; \
    chmod +x /home/docker/mine.sh; \
    chmod +x /home/docker/custom-mine.sh;

# Set environment variables.
ENV BASE="Ubuntu ${BASE}"
ENV DRIVERV="20.20"
ENV PATH=$PATH:/home/docker/phoenixminer
ENV HOME="/home/docker"
ENV POOL="ssl://asia-eth.2miners.com:12020"
ENV WALLET="0xe037C6245910EbBbA720514835d31B385D76927f"
ENV PASSWORD="x"
ENV TT="-80"
ENV TSTOP="85"
ENV TSTART="80"
ENV ADDITIONAL=" "
ENV CUSTOM=""
ENV NVIDIA_BUILD_OPTS="-a -N -q --install-libglvnd --ui=none --no-kernel-module"

# Define working directory.
WORKDIR /home/docker/

# Define default command.
CMD ["./start.sh"]
