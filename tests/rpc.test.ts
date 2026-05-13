import { STGRpcClient } from "../rpc/client";
import { ethers } from "ethers";

describe("STGRpcClient", () => {
  const endpoint = "http://localhost:8545";
  const client = new STGRpcClient(endpoint);

  test("should connect to RPC and fetch block number", async () => {
    const blockNumber = await client.getBlockNumber();
    expect(typeof blockNumber).toBe("number");
  });

  test("should fetch balance for an address", async () => {
    const balance = await client.getBalance("0x0000000000000000000000000000000000000000");
    expect(typeof balance).toBe("string");
  });

  test("should send transaction (mock)", async () => {
    const tx: ethers.TransactionRequest = {
      to: "0x0000000000000000000000000000000000000000",
      value: ethers.parseEther("0.01"),
    };
    // In devnet, this may throw if no signer is available
    await expect(client.sendTransaction(tx)).resolves.not.toThrow();
  });
});
