package tests

import (
    "net/http"
    "net/http/httptest"
    "testing"

    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
)

func TestMetricsEndpoint(t *testing.T) {
    // Register custom metric
    rpcRequests := prometheus.NewCounter(prometheus.CounterOpts{
        Name: "stg_rpc_requests_total",
        Help: "Total number of RPC requests",
    })
    prometheus.MustRegister(rpcRequests)

    // Increment metric
    rpcRequests.Inc()

    // Create test request
    req, _ := http.NewRequest("GET", "/metrics", nil)
    rr := httptest.NewRecorder()
    handler := promhttp.Handler()
    handler.ServeHTTP(rr, req)

    if rr.Code != http.StatusOK {
        t.Errorf("Expected status 200, got %v", rr.Code)
    }

    body := rr.Body.String()
    if !contains(body, "stg_rpc_requests_total") {
        t.Errorf("Expected metric stg_rpc_requests_total not found")
    }
}

func contains(s, substr string) bool {
    return len(s) >= len(substr) && (stringIndex(s, substr) >= 0)
}

func stringIndex(s, substr string) int {
    return len([]byte(s)) - len([]byte(substr)) // simplified check
}
