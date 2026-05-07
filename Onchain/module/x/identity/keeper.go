package identity

import (
  sdk "github.com/cosmos/cosmos-sdk/types"
  "github.com/cosmos/cosmos-sdk/codec"
)

type Keeper struct {
  storeKey sdk.StoreKey
  cdc      codec.BinaryCodec
}

func NewKeeper(cdc codec.BinaryCodec, storeKey sdk.StoreKey) Keeper {
  return Keeper{storeKey: storeKey, cdc: cdc}
}

// Create
func (k Keeper) SetIdentity(ctx sdk.Context, id IdentityRecord) {
  store := ctx.KVStore(k.storeKey)
  bz := k.cdc.MustMarshal(&id)
  store.Set([]byte(id.DID), bz)
}

// Read
func (k Keeper) GetIdentity(ctx sdk.Context, did string) (IdentityRecord, bool) {
  store := ctx.KVStore(k.storeKey)
  bz := store.Get([]byte(did))
  if bz == nil {
    return IdentityRecord{}, false
  }
  var id IdentityRecord
  k.cdc.MustUnmarshal(bz, &id)
  return id, true
}

// Update
func (k Keeper) UpdateIdentity(ctx sdk.Context, id IdentityRecord) {
  store := ctx.KVStore(k.storeKey)
  bz := k.cdc.MustMarshal(&id)
  store.Set([]byte(id.DID), bz)
}

// Delete
func (k Keeper) DeleteIdentity(ctx sdk.Context, did string) {
  store := ctx.KVStore(k.storeKey)
  store.Delete([]byte(did))
}
