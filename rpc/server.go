package rpc

import (
    "encoding/json"
    "net/http"
)

type RPCResponse struct {
    Jsonrpc string      `json:"jsonrpc"`
    Result  interface{} `json:"result"`
    ID      int         `json:"id"`
}

func StartRPCServer() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        response := RPCResponse{
            Jsonrpc: "2.0",
            Result:  "STG-Chain RPC Online",
            ID:      1,
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(response)
    })

    http.ListenAndServe(":8545", nil)
}
