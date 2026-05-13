package main

import (
    "fmt"
    "stg-chain/rpc"
)

func main() {
    fmt.Println("Starting STG-Chain Node...")

    go rpc.StartRPCServer()

    select {}
}
