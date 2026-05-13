package rpc

import (
    "fmt"
    "net/http"

    "github.com/gorilla/websocket"
    "stg-chain/core"
)

var upgrader = websocket.Upgrader{
    CheckOrigin: func(r *http.Request) bool { return true },
}

type WSServer struct {
    clients   map[*websocket.Conn]bool
    broadcast chan string
    state     *core.StateDB
}

func NewWSServer(state *core.StateDB) *WSServer {
    return &WSServer{
        clients:   make(map[*websocket.Conn]bool),
        broadcast: make(chan string),
        state:     state,
    }
}

func (ws *WSServer) handleConnections(w http.ResponseWriter, r *http.Request) {
    conn, err := upgrader.Upgrade(w, r, nil)
    if err != nil {
        fmt.Println("WebSocket upgrade error:", err)
        return
    }
    ws.clients[conn] = true
}

func (ws *WSServer) handleMessages() {
    for {
        msg := <-ws.broadcast
        for client := range ws.clients {
            err := client.WriteMessage(websocket.TextMessage, []byte(msg))
            if err != nil {
                client.Close()
                delete(ws.clients, client)
            }
        }
    }
}

func (ws *WSServer) Start(port int) {
    http.HandleFunc("/ws", ws.handleConnections)
    go ws.handleMessages()
    addr := fmt.Sprintf(":%d", port)
    fmt.Println("WebSocket server listening on", addr)
    http.ListenAndServe(addr, nil)
}

// Trigger event when block mined
func (ws *WSServer) NotifyBlock(blockNum uint64) {
    msg := fmt.Sprintf("New Block: %d", blockNum)
    ws.broadcast <- msg
}

// Trigger event when transaction added
func (ws *WSServer) NotifyTransaction(tx core.Transaction) {
    msg := fmt.Sprintf("New Tx: %s from %s to %s value %d", tx.Hash, tx.From, tx.To, tx.Value)
    ws.broadcast <- msg
}
