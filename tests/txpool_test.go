package tests

import (
    "testing"
    "stg-chain/core"
)

func TestAddTransaction(t *testing.T) {
    pool := core.NewTxPool()
    tx := core.Transaction{From: "0xAAA", To: "0xBBB", Value: 100, Nonce: 1}

    if err := pool.AddTransaction(tx); err != nil {
        t.Fatalf("Unexpected error adding transaction: %v", err)
    }

    if len(pool.GetPendingTransactions()) != 1 {
        t.Errorf("Expected 1 pending transaction")
    }
}

func TestProcessTransactionSuccess(t *testing.T) {
    state := core.NewStateDB()
    state.SetBalance("0xAAA", 500)
    state.SetBalance("0xBBB", 100)

    pool := core.NewTxPool()
    tx := core.Transaction{From: "0xAAA", To: "0xBBB", Value: 200, Nonce: 1}
    pool.AddTransaction(tx)

    if err := pool.ProcessNextTransaction(state); err != nil {
        t.Fatalf("Unexpected error: %v", err)
    }

    if state.GetBalance("0xAAA") != 300 {
        t.Errorf("Expected balance 300 for 0xAAA")
    }
    if state.GetBalance("0xBBB") != 300 {
        t.Errorf("Expected balance 300 for 0xBBB")
    }
}

func TestProcessTransactionInsufficientBalance(t *testing.T) {
    state := core.NewStateDB()
    state.SetBalance("0xAAA", 100)

    pool := core.NewTxPool()
    tx := core.Transaction{From: "0xAAA", To: "0xBBB", Value: 200, Nonce: 1}
    pool.AddTransaction(tx)

    if err := pool.ProcessNextTransaction(state); err == nil {
        t.Errorf("Expected error for insufficient balance")
    }
}

func TestProcessedTransactionsLog(t *testing.T) {
    state := core.NewStateDB()
    state.SetBalance("0xAAA", 1000)
    state.SetBalance("0xBBB", 0)

    pool := core.NewTxPool()
    tx := core.Transaction{From: "0xAAA", To: "0xBBB", Value: 500, Nonce: 1}
    pool.AddTransaction(tx)

    _ = pool.ProcessNextTransaction(state)

    if len(pool.GetProcessedTransactions()) != 1 {
        t.Errorf("Expected 1 processed transaction")
    }
}
