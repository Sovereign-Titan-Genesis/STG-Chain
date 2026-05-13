package tests

import (
    "testing"
    "stg-chain/core"
)

func TestBalanceOperations(t *testing.T) {
    state := core.NewStateDB()

    // Set initial balance
    state.SetBalance("0xAAA", 1000)
    if bal := state.GetBalance("0xAAA"); bal != 1000 {
        t.Errorf("Expected balance 1000, got %d", bal)
    }

    // Update balance
    state.SetBalance("0xAAA", 2000)
    if bal := state.GetBalance("0xAAA"); bal != 2000 {
        t.Errorf("Expected balance 2000, got %d", bal)
    }
}

func TestTransferSuccess(t *testing.T) {
    state := core.NewStateDB()
    state.SetBalance("0xAAA", 1000)
    state.SetBalance("0xBBB", 500)

    err := state.Transfer("0xAAA", "0xBBB", 300)
    if err != nil {
        t.Fatalf("Unexpected error: %v", err)
    }

    if bal := state.GetBalance("0xAAA"); bal != 700 {
        t.Errorf("Expected balance 700, got %d", bal)
    }
    if bal := state.GetBalance("0xBBB"); bal != 800 {
        t.Errorf("Expected balance 800, got %d", bal)
    }
}

func TestTransferInsufficientBalance(t *testing.T) {
    state := core.NewStateDB()
    state.SetBalance("0xAAA", 100)

    err := state.Transfer("0xAAA", "0xBBB", 200)
    if err == nil {
        t.Errorf("Expected error for insufficient balance, got nil")
    }
}

func TestBlockIncrement(t *testing.T) {
    state := core.NewStateDB()

    if blk := state.GetLatestBlock(); blk != 0 {
        t.Errorf("Expected initial block 0, got %d", blk)
    }

    state.IncrementBlock()
    state.IncrementBlock()

    if blk := state.GetLatestBlock(); blk != 2 {
        t.Errorf("Expected block 2, got %d", blk)
    }
}
