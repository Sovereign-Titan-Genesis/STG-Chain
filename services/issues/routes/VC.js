const express = require('express');
const router = express.Router();
const { signVC, anchorHash } = require('../lib/issuer');

router.post('/issue', async (req, res) => {
  const { did, claim } = req.body;
  // validate request, verify supporting docs off-chain
  const vc = await signVC(did, claim);
  const anchor = await anchorHash(vc.hash, did);
  res.json({ vc, anchorTx: anchor.txHash });
});

module.exports = router;
