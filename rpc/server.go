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
	ID      int         `json:"id"`
	Result  interface{} `json:"result,omitempty"`
	Error   interface{} `json:"error,omitempty"`
}

func handler(w http.ResponseWriter, r *http.Request) {
	var req RPCRequest

	err := json.NewDecoder(r.Body).Decode(&req)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	var result interface{}

	switch req.Method {

	case "eth_blockNumber":
		result = "0x1"

	case "net_version":
		result = "777"

	case "eth_chainId":
		result = "0x309"

	default:
		result = nil
	}

	resp := RPCResponse{
		JSONRPC: "2.0",
		ID:      req.ID,
		Result:  result,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(resp)
}

func StartRPCServer(port int) {
	http.HandleFunc("/", handler)

	addr := fmt.Sprintf(":%d", port)

	log.Printf("STG RPC listening on %s\n", addr)

	err := http.ListenAndServe(addr, nil)
	if err != nil {
		log.Fatal(err)
	}
}
