const express = require('express');
const app = express();
const vcRoutes = require('./routes/vc');

app.use(express.json());
app.use('/vc', vcRoutes);

app.listen(3000, () => console.log("Issuer service running on port 3000"));
