const express = require('express');
const app = express();
app.use(express.json());

app.post('/issue', (req, res) => {
  const { did, claim } = req.body;
  // TODO: verify claim off-chain
  const vc = { did, claim, proof: "signed-by-issuer" };
  // TODO: anchor hash on-chain
  res.json({ vc, anchorTx: "tx123" });
});

app.listen(3000, () => console.log("Issuer service running on port 3000"));
