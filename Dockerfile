FROM debian:bullseye-slim


RUN apt-get update -y \
  && apt-get install -y curl jq unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG VERSION

RUN curl -LOJ "https://github.com/bnb-chain/bsc/releases/download/v${VERSION}/mainnet.zip" && \
    curl -LOJ "https://github.com/bnb-chain/bsc/releases/download/v${VERSION}/geth_linux" && \
    unzip mainnet.zip -d / && \
    mv /mainnet/* /. && rm -rf /mainnet && \
    sed -i 's/^HTTPHost.*/HTTPHost = "0.0.0.0"/' /mainnet/config.toml && \
    sed -i '/^WSPort.*/a WSHost = "0.0.0.0"' /mainnet/config.toml && \
    sed -i 's/^HTTPVirtualHosts.*/HTTPVirtualHosts = ["*"]/' /mainnet/config.toml && \
    sed -i '/Node\.LogConfig/,/^$/d' /mainnet/config.toml && \ 
    mv geth_linux /usr/local/bin/bsc && \
    chmod +x /usr/local/bin/bsc

ENV BSC_DATADIR=/root/.ethereum

COPY docker-entrypoint.sh /entrypoint.sh

#VOLUME ["$BSC_DATADIR"]

# NODE P2P
EXPOSE 30311/udp
EXPOSE 30311/tcp

# pprof / metrics
EXPOSE 6060/tcp

# HTTP based JSON RPC API
EXPOSE 8545/tcp
# WebSocket based JSON RPC API
EXPOSE 8546/tcp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bsc"]
