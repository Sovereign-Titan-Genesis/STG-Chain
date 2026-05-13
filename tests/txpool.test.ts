import { describe, it, expect } from "vitest";
import { TxPool, Transaction, StateDB } from "../core/txpool";

describe("TxPool", () => {
  it("adds transaction to pending queue", () => {
    const pool = new TxPool();
    const tx: Transaction = { from: "0xAAA", to: "0xBBB", value: 100, nonce: 1 };
    pool.addTransaction(tx);
    expect(pool.getPendingTransactions().length).toBe(1);
  });

  it("processes transaction successfully", () => {
    const state = new StateDB();
    state.setBalance("0xAAA", 500);
    state.setBalance("0xBBB", 100);

    const pool = new TxPool();
    const tx: Transaction = { from: "0xAAA", to: "0xBBB", value: 200, nonce: 1 };
    pool.addTransaction(tx);

    const result = pool.processNextTransaction(state);
    expect(result).toBe(true);
    expect(state.getBalance("0xAAA")).toBe(300);
    expect(state.getBalance("0xBBB")).toBe(300);
  });

  it("fails transaction with insufficient balance", () => {
    const state = new StateDB();
    state.setBalance("0xAAA", 100);

    const pool = new TxPool();
    const tx: Transaction = { from: "0xAAA", to: "0xBBB", value: 200, nonce: 1 };
    pool.addTransaction(tx);

    const result = pool.processNextTransaction(state);
    expect(result).toBe(false);
  });

  it("logs processed transactions", () => {
    const state = new StateDB();
    state.setBalance("0xAAA", 1000);
    state.setBalance("0xBBB", 0);

    const pool = new TxPool();
    const tx: Transaction = { from: "0xAAA", to: "0xBBB", value: 500, nonce: 1 };
    pool.addTransaction(tx);

    pool.processNextTransaction(state);
    expect(pool.getProcessedTransactions().length).toBe(1);
  });
});
