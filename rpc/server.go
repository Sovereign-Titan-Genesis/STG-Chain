package rpc

import (
    "encoding/json"
    "fmt"
    "io/ioutil"
    "net/http"
)

// JSONRPCRequest defines the structure of incoming RPC requests
type JSONRPCRequest struct {
    JSONRPC string        `json:"jsonrpc"`
    Method  string        `json:"method"`
    Params  []interface{} `json:"params"`
    ID      int           `json:"id"`
}

// JSONRPCResponse defines the structure of outgoing RPC responses
type JSONRPCResponse struct {
    JSONRPC string      `json:"jsonrpc"`
    Result  interface{} `json:"result,omitempty"`
    Error   interface{} `json:"error,omitempty"`
    ID      int         `json:"id"`
}

// StartRPCServer boots a minimal HTTP JSON-RPC server
func StartRPCServer(port int) {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        body, err := ioutil.ReadAll(r.Body)
        if err != nil {
            http.Error(w, "Failed to read request body", http.StatusBadRequest)
            return
        }

        var req JSONRPCRequest
        if err := json.Unmarshal(body, &req); err != nil {
            http.Error(w, "Invalid JSON", http.StatusBadRequest)
            return
        }

        var res JSONRPCResponse
        res.JSONRPC = "2.0"
        res.ID = req.ID

        switch req.Method {
        case "eth_blockNumber":
            // Stub: return latest block number (hex string)
            res.Result = "0x0"
        case "eth_getBalance":
            // Stub: return dummy balance for requested address
            if len(req.Params) > 0 {
                address := req.Params[0].(string)
                res.Result = fmt.Sprintf("Balance for %s: 0xDE0B6B3A7640000", address) // 1 ETH
            } else {
                res.Error = "Missing address parameter"
            }
        default:
            res.Error = fmt.Sprintf("Method %s not implemented", req.Method)
        }

        w.Header().Set("Content-Type", "application/json")
        json.NewEncoder(w).Encode(res)
    })

    addr := fmt.Sprintf(":%d", port)
    fmt.Printf("🚀 STG-Chain RPC server listening on %s\n", addr)
    http.ListenAndServe(addr, nil)
}
