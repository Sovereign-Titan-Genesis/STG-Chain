package main

import (
	"flag"
	"fmt"
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
		"HTTP JSON-RPC port",
	)

	flag.Parse()

	fmt.Println("--------------------------------------------------")
	fmt.Println("STG Sovereign Node Booting")
	fmt.Println("--------------------------------------------------")

	// Check genesis file existence
	if _, err := os.Stat(*genesisPath); err != nil {
		fmt.Printf("Failed to load genesis: %v\n", err)
		os.Exit(1)
	}

	fmt.Printf("Genesis Loaded: %s\n", *genesisPath)
	fmt.Printf("RPC Port: %d\n", *rpcPort)

	// Start RPC server
	rpc.StartRPCServer(*rpcPort)
}
