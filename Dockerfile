FROM debian:bullseye-slim


RUN apt-get update -y \
  && apt-get install -y curl jq unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV VERSION=1.1.0-beta

RUN curl --silent "https://api.github.com/repos/binance-chain/bsc/releases/tags/v${VERSION}" | jq -c '.assets[] | select( .browser_download_url | contains("mainnet.zip") or contains("geth_linux")) | .browser_download_url' | xargs -n1 curl -LOJ && \
    unzip mainnet.zip -d / && \
    sed -i 's/^HTTPHost.*/HTTPHost = "0.0.0.0"/' /config.toml && \
    sed -i '/^WSPort.*/a WSHost = "0.0.0.0"' /config.toml && \
    sed -i 's/^HTTPVirtualHosts.*/HTTPVirtualHosts = ["*"]/' /config.toml && \
    sed -i '/Node\.LogConfig/,/^$/d' /config.toml && \ 
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
