import crypto from 'crypto';

// generate kunci simetris AES
export function generateSymKey(): Buffer {
  return crypto.randomBytes(32); // AES-256
}

// enkripsi payload JSON dengan AES
export function encryptPayload(payload: any, symKey: Buffer): { ciphertext: string, iv: string } {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipheriv('aes-256-gcm', symKey, iv);
  const data = Buffer.from(JSON.stringify(payload));
  const encrypted = Buffer.concat([cipher.update(data), cipher.final()]);
  return { ciphertext: encrypted.toString('hex'), iv: iv.toString('hex') };
}

// dekripsi payload
export function decryptPayload(ciphertext: string, iv: string, symKey: Buffer): any {
  const decipher = crypto.createDecipheriv('aes-256-gcm', symKey, Buffer.from(iv, 'hex'));
  const decrypted = Buffer.concat([
    decipher.update(Buffer.from(ciphertext, 'hex')),
    decipher.final()
  ]);
  return JSON.parse(decrypted.toString());
}
