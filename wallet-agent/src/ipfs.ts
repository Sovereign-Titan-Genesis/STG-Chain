import { create } from 'ipfs-http-client';
import { encryptPayload, decryptPayload, generateSymKey } from './crypto';

const client = create({ url: 'http://localhost:5001' }); // pastikan IPFS daemon jalan

export async function uploadEncrypted(payload: any): Promise<{ cid: string, symKey: string, iv: string }> {
  const symKey = generateSymKey();
  const { ciphertext, iv } = encryptPayload(payload, symKey);
  const { cid } = await client.add(ciphertext);
  return { cid: cid.toString(), symKey: symKey.toString('hex'), iv };
}

export async function fetchAndDecrypt(cid: string, symKeyHex: string, iv: string): Promise<any> {
  const data = [];
  for await (const chunk of client.cat(cid)) {
    data.push(chunk);
  }
  const ciphertext = Buffer.concat(data).toString();
  const symKey = Buffer.from(symKeyHex, 'hex');
  return decryptPayload(ciphertext, iv, symKey);
}
