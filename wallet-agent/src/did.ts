import { sha256 } from 'js-sha256';

export function createDid(publicKeyHex: string, controller: string) {
  const did = `did:stg:${sha256(publicKeyHex).slice(0,16)}`;
  const doc = {
    "@context": ["https://www.w3.org/ns/did/v1"],
    id: did,
    controller,
    verificationMethod: [{
      id: `${did}#key-1`,
      type: "Ed25519VerificationKey2018",
      controller: did,
      publicKeyHex
    }]
  };
  return { did, doc };
}
