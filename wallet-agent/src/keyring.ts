import * as ed from '@noble/ed25519';

export class Keyring {
  private privateKey: Uint8Array;
  public publicKey: string;

  constructor() {
    this.privateKey = ed.utils.randomPrivateKey();
    this.publicKey = Buffer.from(ed.getPublicKey(this.privateKey)).toString('hex');
  }

  async sign(message: string): Promise<string> {
    const signature = await ed.sign(Buffer.from(message), this.privateKey);
    return Buffer.from(signature).toString('hex');
  }
}
