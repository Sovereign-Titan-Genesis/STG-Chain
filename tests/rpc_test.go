package tests

import (
    "net/http"
    "net/http/httptest"
    "testing"
    "stg-chain/rpc"
)

func TestRPCServer_StatusEndpoint(t *testing.T) {
    server := rpc.NewRPCServer(":8080")

    // Create a test HTTP request
    req, err := http.NewRequest("GET", "/status", nil)
    if err != nil {
        t.Fatal(err)
    }

    rr := httptest.NewRecorder()
    handler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        w.WriteHeader(http.StatusOK)
        w.Write([]byte("STG-Chain RPC is running"))
    })

    handler.ServeHTTP(rr, req)

    if status := rr.Code; status != http.StatusOK {
        t.Errorf("Expected status code %v, got %v", http.StatusOK, status)
    }

    expected := "STG-Chain RPC is running"
    if rr.Body.String() != expected {
        t.Errorf("Expected body %v, got %v", expected, rr.Body.String())
    }
}
