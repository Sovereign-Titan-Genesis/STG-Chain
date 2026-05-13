import { describe, it, expect } from "vitest";
import { StateDB } from "../core/state";

describe("StateDB", () => {
  it("should set and get balance", () => {
    const state = new StateDB();
    state.setBalance("0xAAA", 1000);
    expect(state.getBalance("0xAAA")).toBe(1000);
  });

  it("should transfer successfully", () => {
    const state = new StateDB();
    state.setBalance("0xAAA", 1000);
    state.setBalance("0xBBB", 500);

    const result = state.transfer("0xAAA", "0xBBB", 300);
    expect(result).toBe(true);
    expect(state.getBalance("0xAAA")).toBe(700);
    expect(state.getBalance("0xBBB")).toBe(800);
  });

  it("should fail transfer with insufficient balance", () => {
    const state = new StateDB();
    state.setBalance("0xAAA", 100);

    const result = state.transfer("0xAAA", "0xBBB", 200);
    expect(result).toBe(false);
  });

  it("should increment block height", () => {
    const state = new StateDB();
    expect(state.getLatestBlock()).toBe(0);

    state.incrementBlock();
    state.incrementBlock();

    expect(state.getLatestBlock()).toBe(2);
  });
});
