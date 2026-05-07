package tests

import (
  "testing"
  "github.com/stretchr/testify/require"
  "stg-chain/soul-id/onchain/module/x/identity"
)

func TestIdentityRecord(t *testing.T) {
  rec := identity.IdentityRecord{
    DID: "did:stg:abcd1234",
    Controller: "stg1xyz...",
  }
  require.Equal(t, "did:stg:abcd1234", rec.DID)
}
