package types

import "time"

type IdentityRecord struct {
  DID               string    `json:"did"`
  Controller        string    `json:"controller"`
  PublicKeys        []PubKey  `json:"public_keys"`
  DocHash           string    `json:"doc_hash"`
  CreatedAt         time.Time `json:"created_at"`
  Revoked           bool      `json:"revoked"`
  RevocationPointer string    `json:"revocation_pointer"`
}

type PubKey struct {
  KeyID     string `json:"key_id"`
  KeyType   string `json:"key_type"`
  PublicKey string `json:"public_key"`
}
