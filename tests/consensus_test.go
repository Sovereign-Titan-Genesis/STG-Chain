package tests

import (
    "testing"
    "time"
    "stg-chain/consensus"
)

func TestIBFTConsensus_Start(t *testing.T) {
    validators := []string{"validator1", "validator2", "validator3"}
    engine := consensus.NewIBFTConsensus(validators, 30000, 3*time.Second)

    err := engine.Start()
    if err != nil {
        t.Errorf("Consensus failed to start: %v", err)
    }
}

func TestIBFTConsensus_ProposeValidateCommit(t *testing.T) {
    validators := []string{"validator1", "validator2", "validator3"}
    engine := consensus.NewIBFTConsensus(validators, 30000, 3*time.Second)

    blockData := []byte("test-block")
    err := engine.ProposeBlock(blockData)
    if err != nil {
        t.Errorf("Failed to propose block: %v", err)
    }

    if !engine.ValidateBlock(blockData) {
        t.Errorf("Block validation failed")
    }

    err = engine.CommitBlock(blockData)
    if err != nil {
        t.Errorf("Failed to commit block: %v", err)
    }
}
