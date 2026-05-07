import { Keyring } from './keyring';
import { createDid } from './did';
import { LocalStorage } from './storage';
import { storeVC, verifyVC } from './vc';

async function main() {
  // buat keyring
  const keyring = new Keyring();
  console.log("Public Key:", keyring.publicKey);

  // buat DID
  const { did, doc } = createDid(keyring.publicKey, "stg1xyz...");
  console.log("Created DID:", did);
  console.log("DID Document:", doc);

  // simpan VC dummy
  const storage = new LocalStorage();
  const vc = {
    "@context": ["https://www.w3.org/2018/credentials/v1"],
    id: "vc-123",
    type: ["VerifiableCredential"],
    issuer: "did:stg:issuer123",
    issuanceDate: new Date().toISOString(),
    credentialSubject: { id: did, claim: "Contributor" },
    proof: { signatureValue: "dummy-signature" }
  };
  storeVC(vc, storage);

  // verifikasi VC
  const valid = verifyVC(vc);
  console.log("VC valid?", valid);
}

main();
