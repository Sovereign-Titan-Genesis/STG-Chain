package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"stg-chain/rpc"
)

func main() {
	genesisPath := flag.String(
		"genesis",
		"core/genesis.json",
		"Path to genesis configuration",
	)

	rpcPort := flag.Int(
		"rpc.port",
		8545,
		"RPC listening port",
	)

	flag.Parse()

	fmt.Println("======================================")
	fmt.Println("STG Sovereign Node Booting")
	fmt.Println("======================================")

	if _, err := os.Stat(*genesisPath); err != nil {
		log.Fatalf("genesis file not found: %v", err)
	}

	fmt.Printf("Genesis Loaded: %s\n", *genesisPath)
	fmt.Printf("RPC Port: %d\n", *rpcPort)

	rpc.StartRPCServer(*rpcPort)
}
