#!/bin/bash
# params: DID, attestation_hash
DID=$1
HASH=$2
# broadcast tx to identity module
./build/stgchaind tx identity anchor $DID $HASH --from validator --chain-id stg-dev -y
