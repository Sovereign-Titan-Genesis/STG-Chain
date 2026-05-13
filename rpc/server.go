// File: rpc/server.go
package rpc

import (
    "fmt"
    "net/http"
)

// RPCServer defines the HTTP/WebSocket server
type RPCServer struct {
    address string
}

// NewRPCServer initializes a new RPC server
func NewRPCServer(address string) *RPCServer {
    return &RPCServer{address: address}
}

func (s *RPCServer) Start() error {
    http.HandleFunc("/status", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "STG-Chain RPC is running at %s", s.address)
    })

    fmt.Println("Starting RPC server at", s.address)
    return http.ListenAndServe(s.address, nil)
}
