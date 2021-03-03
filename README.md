# Binance Smart Chain node Docker image

## QuickStart

`docker run -d -v/data/bsc:/root -p 30311:30311 -p 8575:8545 --name binance-smart-chain-node vlddm/binance-smart-chain-node:latest --syncmode fast --nousb --cache 4096`

Blockchain data will be stored at `/data/bsc` folder.

## Check sync status

```
docker exec binance-smart-chain-node bsc attach --exec eth.syncing

docker logs -f binance-smart-chain-node
```

## JSONRPC

Use port 8575 as JSONRPC endpoint.

## More info

[original BSC repo](https://github.com/binance-chain/bsc)
