#!/bin/sh
set -e

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for bsc"

  set -- bsc "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "bsc" ]; then

  if [ ! -d $BSC_DATADIR/geth/chaindata ]; then
    mkdir -p "$BSC_DATADIR"
    chmod 700 "$BSC_DATADIR"
    bsc --nousb --datadir "$BSC_DATADIR" init /genesis.json
  fi

  echo "$0: setting data directory to $BSC_DATADIR"

  set -- "$@" --datadir "$BSC_DATADIR" --config /config.toml
fi

echo
exec "$@"
