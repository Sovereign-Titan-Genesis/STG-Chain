package identity

import (
  sdk "github.com/cosmos/cosmos-sdk/types"
)

type MsgCreateDid struct {
  Did        string
  Controller string
  PublicKeys []PubKey
  DocHash    string
}

func (msg MsgCreateDid) Route() string { return "identity" }
func (msg MsgCreateDid) Type() string  { return "create_did" }
func (msg MsgCreateDid) GetSigners() []sdk.AccAddress {
  addr, _ := sdk.AccAddressFromBech32(msg.Controller)
  return []sdk.AccAddress{addr}
}

// MsgUpdateDid & MsgDeleteDid bisa dibuat dengan pola sama
