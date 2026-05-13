package core

import (
    "errors"
    "sync"
)

// StateDB adalah database sederhana untuk menyimpan saldo dan block height
type StateDB struct {
    mu        sync.RWMutex
    balances  map[string]uint64
    latestBlk uint64
}

// NewStateDB membuat instance baru StateDB
func NewStateDB() *StateDB {
    return &StateDB{
        balances:  make(map[string]uint64),
        latestBlk: 0,
    }
}

// GetBalance mengembalikan saldo address tertentu
func (s *StateDB) GetBalance(address string) uint64 {
    s.mu.RLock()
    defer s.mu.RUnlock()
    return s.balances[address]
}

// SetBalance menetapkan saldo address tertentu
func (s *StateDB) SetBalance(address string, amount uint64) {
    s.mu.Lock()
    defer s.mu.Unlock()
    s.balances[address] = amount
}

// Transfer memindahkan saldo antar address
func (s *StateDB) Transfer(from, to string, amount uint64) error {
    s.mu.Lock()
    defer s.mu.Unlock()

    if s.balances[from] < amount {
        return errors.New("insufficient balance for transaction")
    }

    s.balances[from] -= amount
    s.balances[to] += amount
    return nil
}

// IncrementBlock menambah block height
func (s *StateDB) IncrementBlock() {
    s.mu.Lock()
    defer s.mu.Unlock()
    s.latestBlk++
}

// GetLatestBlock mengembalikan block height terbaru
func (s *StateDB) GetLatestBlock() uint64 {
    s.mu.RLock()
    defer s.mu.RUnlock()
    return s.latestBlk
}
