FROM debian:bullseye-slim


RUN apt-get update -y \
  && apt-get install -y curl jq unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV VERSION=1.0.6

RUN curl --silent "https://api.github.com/repos/binance-chain/bsc/releases/tags/v${VERSION}" | jq -c '.assets[] | select( .browser_download_url | contains("mainnet.zip") or contains("geth_linux")) | .browser_download_url' | xargs -n1 curl -LOJ && \
    unzip mainnet.zip -d / && \
    sed -i '/Node\.LogConfig/,/^$/d' /config.toml && \ 
    mv geth_linux /usr/local/bin/bsc && \
    chmod +x /usr/local/bin/bsc


ENV BSC_DATADIR=/root/.ethereum

COPY docker-entrypoint.sh /entrypoint.sh

#VOLUME ["$BSC_DATADIR"]

EXPOSE 8575 8576 8577 30311 30311/udp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bsc"]
