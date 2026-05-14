package core

import (
    "encoding/json"
    "fmt"

    "github.com/syndtr/goleveldb/leveldb"
)

type Storage struct {
    db *leveldb.DB
}

func NewStorage(path string) (*Storage, error) {
    db, err := leveldb.OpenFile(path, nil)
    if err != nil {
        return nil, err
    }
    return &Storage{db: db}, nil
}

func (s *Storage) Close() {
    s.db.Close()
}

// SaveStateDB menyimpan snapshot StateDB ke LevelDB
func (s *Storage) SaveState(state *StateDB) error {
    data, err := json.Marshal(state)
    if err != nil {
        return err
    }
    return s.db.Put([]byte("state_snapshot"), data, nil)
}

// LoadStateDB memuat snapshot StateDB dari LevelDB
func (s *Storage) LoadState() (*StateDB, error) {
    data, err := s.db.Get([]byte("state_snapshot"), nil)
    if err != nil {
        return nil, err
    }
    var state StateDB
    err = json.Unmarshal(data, &state)
    if err != nil {
        return nil, err
    }
    return &state, nil
}
