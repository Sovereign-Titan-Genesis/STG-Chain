import { describe, it, expect } from "vitest";
import { MultiSigContract } from "../governance/contract";

describe("MultiSig Governance Contract", () => {
  const council = ["val1", "val2", "val3", "val4", "val5"];

  it("executes proposal with quorum", () => {
    const contract = new MultiSigContract(council, 3);
    contract.sign("val1");
    contract.sign("val2");
    contract.sign("val3");

    expect(contract.hasQuorum()).toBe(true);
    expect(contract.executeProposal("Community Fund Allocation")).toBe(true);
  });

  it("fails proposal without quorum", () => {
    const contract = new MultiSigContract(council, 3);
    contract.sign("val1");
    contract.sign("val2");

    expect(contract.hasQuorum()).toBe(false);
    expect(contract.executeProposal("Invalid Proposal")).toBe(false);
  });
});
