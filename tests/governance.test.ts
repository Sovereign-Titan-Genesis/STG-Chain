import { MultiSigContract } from "../governance/contract";

describe("MultiSig Governance Contract", () => {
  const council = ["val1", "val2", "val3", "val4", "val5"];
  const contract = new MultiSigContract(council, 3); // 3-of-5 quorum

  test("should reach quorum with 3 signatures", () => {
    contract.sign("val1");
    contract.sign("val2");
    contract.sign("val3");

    expect(contract.hasQuorum()).toBe(true);
    expect(contract.executeProposal("Allocate Community Fund")).toBe(true);
  });

  test("should fail quorum with only 2 signatures", () => {
    const contract2 = new MultiSigContract(council, 3);
    contract2.sign("val1");
    contract2.sign("val2");

    expect(contract2.hasQuorum()).toBe(false);
    expect(contract2.executeProposal("Fail Proposal")).toBe(false);
  });
});
