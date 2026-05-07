export interface VerifiableCredential {
  "@context": string[];
  id: string;
  type: string[];
  issuer: string;
  issuanceDate: string;
  credentialSubject: any;
  proof: any;
}

export function storeVC(vc: VerifiableCredential, storage: any) {
  storage.save(vc.id, vc);
}

export function verifyVC(vc: VerifiableCredential): boolean {
  // cek struktur minimal
  if (!vc.credentialSubject || !vc.proof) return false;
  // cek signature dummy
  return vc.proof.signatureValue === "dummy-signature";
}
