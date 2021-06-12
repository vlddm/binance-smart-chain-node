# Binance Smart Chain node Docker image

## QuickStart

```
docker run -d -v /data/bsc:/root --name binance-smart-chain-node \
-p 127.0.0.1:8545:8545 -p 127.0.0.1:8546:8546 -p 127.0.0.1:6060:6060 -p 30311:30311 -p 30311:30311/udp \
vlddm/binance-smart-chain-node:latest --syncmode snap --cache 4096
```

Blockchain data will be stored at `/data/bsc` folder.

`config.toml` will be created if not exists at `/data/bsc/.ethereum/config.toml`

## Check sync status

```
docker exec binance-smart-chain-node bsc attach --exec eth.syncing

docker logs -f binance-smart-chain-node
```

## JSONRPC

* HTTP JSONRPC at port 8545
* WebSocket at 8546
* IPC (unix socket) at /data/bsc/.ethereum/geth.ipc

Test it using [geth_linux](https://github.com/binance-chain/bsc/releases) binary: 

```
geth_linux attach http://localhost:8545
geth_linux attach ws://localhost:8546
geth_linux attach /data/bsc/.ethereum/geth.ipc
# Last one needs root privileges
```

## More info

[original BSC repo](https://github.com/binance-chain/bsc)
