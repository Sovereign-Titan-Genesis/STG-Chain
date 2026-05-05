#!/bin/bash
# build chain binary
make build
# init node
./build/stgchaind init devnet --chain-id stg-dev
# add genesis accounts, validators (example)
./build/stgchaind add-genesis-account stg1... 1000000000ustg
# start single-node devnet
./build/stgchaind start
