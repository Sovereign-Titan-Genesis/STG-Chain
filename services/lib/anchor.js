// fungsi dummy untuk broadcast anchor ke chain
async function anchorHash(hash, did) {
  console.log(`Anchoring hash ${hash} for DID ${did}`);
  return { txHash: "tx-" + Date.now() };
}

module.exports = { anchorHash };
