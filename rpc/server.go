package rpc

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

type RPCRequest struct {
	JSONRPC string        `json:"jsonrpc"`
	Method  string        `json:"method"`
	Params  []interface{} `json:"params"`
	ID      int           `json:"id"`
}

type RPCResponse struct {
	JSONRPC string      `json:"jsonrpc"`
	Result   interface{} `json:"result,omitempty"`
	Error    interface{} `json:"error,omitempty"`
	ID       int         `json:"id"`
}

var currentBlock uint64 = 1

func rpcHandler(w http.ResponseWriter, r *http.Request) {
	var req RPCRequest

	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}

	resp := RPCResponse{
		JSONRPC: "2.0",
		ID:      req.ID,
	}

	switch req.Method {

	case "eth_chainId":
		resp.Result = "0x309"

	case "web3_clientVersion":
		resp.Result = "STG-Chain/v0.1"

	case "eth_blockNumber":
		resp.Result = fmt.Sprintf("0x%x", currentBlock)

	default:
		resp.Error = "method not supported"
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func StartRPCServer(port int) {
	addr := fmt.Sprintf(":%d", port)

	http.HandleFunc("/", rpcHandler)

	fmt.Println("STG RPC listening on", addr)

	err := http.ListenAndServe(addr, nil)
	if err != nil {
		log.Fatal(err)
	}
}
