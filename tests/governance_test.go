package tests

import (
    "testing"
    "stg-chain/governance"
)

// Mock council of 5 validators
var council = []string{"val1", "val2", "val3", "val4", "val5"}

func TestMultiSigQuorum(t *testing.T) {
    contract := governance.NewMultiSigContract(council, 3) // 3-of-5 quorum

    // Simulate signatures
    contract.Sign("val1")
    contract.Sign("val2")
    contract.Sign("val3")

    if !contract.HasQuorum() {
        t.Errorf("Expected quorum reached with 3 signatures, got false")
    }

    // Execute proposal
    executed := contract.ExecuteProposal("Allocate Community Fund")
    if !executed {
        t.Errorf("Expected proposal execution, got false")
    }
}

func TestInsufficientQuorum(t *testing.T) {
    contract := governance.NewMultiSigContract(council, 3)

    contract.Sign("val1")
    contract.Sign("val2")

    if contract.HasQuorum() {
        t.Errorf("Quorum should not be reached with only 2 signatures")
    }
}
