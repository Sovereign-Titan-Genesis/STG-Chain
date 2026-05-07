const express = require('express');
const router = express.Router();
const { signVC } = require('../lib/issuer');
const { anchorHash } = require('../lib/anchor');

router.post('/issue', async (req, res) => {
  const { did, claim } = req.body;
  const vc = signVC(did, claim);
  const anchor = await anchorHash(vc.hash, did);
  res.json({ vc, anchorTx: anchor.txHash });
});

module.exports = router;
