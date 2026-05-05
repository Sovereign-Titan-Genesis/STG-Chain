import * as ed from '@noble/ed25519';
import { sha256 } from 'js-sha256';

export async function createDid(publicKeyHex: string, controller: string) {
  const did = `did:stg:${sha256(publicKeyHex).slice(0,16)}`;
  const doc = {
    id: did,
    controller,
    verificationMethod: [{ id: `${did}#key-1`, type: 'Ed25519VerificationKey2018', publicKeyHex }]
  };
  return { did, doc };
}
