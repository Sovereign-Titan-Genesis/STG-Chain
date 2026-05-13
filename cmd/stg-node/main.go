package main

import (
	"flag"
	"fmt"
	"os"
)

func main() {
	genesisPath := flag.String("genesis", "config/genesis.json", "Path to the genesis JSON file configuration")
	rpcPort := flag.Int("rpc.port", 8545, "Network port for HTTP JSON-RPC endpoint")
	isValidator := flag.Bool("validator", false, "Enable consensus validation block signer mode")

	flag.Parse()

	fmt.Println("------------------------------------------------------------")
	fmt.Println("🚀 INITIALIZING SOVEREIGN TITAN GENESIS NODE (STG-NODE)")
	fmt.Println("------------------------------------------------------------")

	data, err := os.ReadFile(*genesisPath)
	if err != nil {
		fmt.Printf("🚨 Initialization Error: Unable to read genesis from path %s: %v\n", *genesisPath, err)
		os.Exit(1)
	}

	fmt.Printf("✅ Genesis State File Read Successfully from: %s\n", *genesisPath)
	fmt.Printf("📡 JSON-RPC API Port Configured on: :%d\n", *rpcPort)
	fmt.Printf("🛡️  Consensus Block Signer (Validator Mode): %t\n", *isValidator)
	fmt.Println("------------------------------------------------------------")

	sampleLen := 60
	if len(data) < sampleLen {
		sampleLen = len(data)
	}
	fmt.Printf("⚙️  Payload Sample Loaded: %s...\n", string(data[:sampleLen]))
	fmt.Println(">>> [SYSTEM] THE GIANT IS BREATHING ON BAREMETAL INTERFACE.")
	fmt.Println("------------------------------------------------------------")
}
