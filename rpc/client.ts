// File: rpc/client.ts
import { ethers } from "ethers";

export class STGRpcClient {
  provider: ethers.JsonRpcProvider;

  constructor(endpoint: string) {
    this.provider = new ethers.JsonRpcProvider(endpoint);
  }

  async getBlockNumber(): Promise<number> {
    return await this.provider.getBlockNumber();
  }

  async getBalance(address: string): Promise<string> {
    const balance = await this.provider.getBalance(address);
    return ethers.formatEther(balance);
  }

  async sendTransaction(tx: ethers.TransactionRequest) {
    return await this.provider.sendTransaction(tx);
  }
}
