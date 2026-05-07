const crypto = require('crypto');

// contoh fungsi untuk menandatangani VC
function signVC(did, claim) {
  const vc = {
    "@context": ["https://www.w3.org/2018/credentials/v1"],
    id: "vc-" + crypto.randomUUID(),
    type: ["VerifiableCredential"],
    issuer: "did:stg:issuer123",
    issuanceDate: new Date().toISOString(),
    credentialSubject: { id: did, claim },
    proof: { type: "Ed25519Signature2018", created: new Date().toISOString(), signatureValue: "dummy-signature" }
  };
  vc.hash = crypto.createHash('sha256').update(JSON.stringify(vc)).digest('hex');
  return vc;
}

module.exports = { signVC };
