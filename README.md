# Binance Smart Chain node Docker image

## QuickStart

`docker run -d -v /data/bsc:/root --name binance-smart-chain-node vlddm/binance-smart-chain-node:latest --syncmode snap --cache 4096`

Blockchain data will be stored at `/data/bsc` folder.

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
```


## More info

[original BSC repo](https://github.com/binance-chain/bsc)
