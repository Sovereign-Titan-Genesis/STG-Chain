package identity

import (
  sdk "github.com/cosmos/cosmos-sdk/types"
)

func NewHandler(k Keeper) sdk.Handler {
  return func(ctx sdk.Context, msg sdk.Msg) (*sdk.Result, error) {
    switch msg := msg.(type) {
    case MsgCreateDid:
      id := IdentityRecord{
        DID:        msg.Did,
        Controller: msg.Controller,
        PublicKeys: msg.PublicKeys,
        DocHash:    msg.DocHash,
        CreatedAt:  ctx.BlockTime(),
        Revoked:    false,
      }
      k.SetIdentity(ctx, id)
      return &sdk.Result{Events: ctx.EventManager().Events()}, nil

    case MsgUpdateDid:
      rec, found := k.GetIdentity(ctx, msg.Did)
      if !found {
        return nil, sdkerrors.Wrap(sdkerrors.ErrNotFound, "DID not found")
      }
      rec.DocHash = msg.DocHash
      rec.PublicKeys = msg.PublicKeys
      k.UpdateIdentity(ctx, rec)
      return &sdk.Result{Events: ctx.EventManager().Events()}, nil

    case MsgDeleteDid:
      k.DeleteIdentity(ctx, msg.Did)
      return &sdk.Result{Events: ctx.EventManager().Events()}, nil

    default:
      return nil, sdkerrors.Wrap(sdkerrors.ErrUnknownRequest, "unknown identity message")
    }
  }
}
