package identity

import (
  sdk "github.com/cosmos/cosmos-sdk/types"
)

type Keeper struct {
  storeKey sdk.StoreKey
}

func NewKeeper(storeKey sdk.StoreKey) Keeper {
  return Keeper{storeKey: storeKey}
}

func (k Keeper) SetIdentity(ctx sdk.Context, id IdentityRecord) {
  store := ctx.KVStore(k.storeKey)
  bz := k.cdc.MustMarshal(&id)
  store.Set([]byte(id.DID), bz)
}

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
