import { IBFTConsensus } from "../consensus/engine";

describe("IBFTConsensus", () => {
  const validators = ["validator1", "validator2", "validator3"];
  const engine = new IBFTConsensus(validators, 30000, 3);

  test("should start consensus engine", () => {
    expect(() => engine.start()).not.toThrow();
  });

  test("should propose, validate, and commit block", () => {
    const blockData = "test-block";

    expect(() => engine.proposeBlock(blockData)).not.toThrow();
    expect(engine.validateBlock(blockData)).toBe(true);
    expect(() => engine.commitBlock(blockData)).not.toThrow();
  });
});
