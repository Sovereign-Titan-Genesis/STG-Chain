const express = require('express');
const app = express();
const vcRoutes = require('./routes/vc');

app.use(express.json());
app.use('/vc', vcRoutes);

app.listen(3000, () => console.log("Issuer service running on port 3000"));
from flask import Flask, request, jsonify
from lib.verifier import verify_vc

app = Flask(__name__)

@app.route('/vc/verify', methods=['POST'])
def verify():
    data = request.get_json()
    vc_json = json.dumps(data.get("vc"))
    result = verify_vc(vc_json)
    return jsonify(result)

if __name__ == "__main__":
    app.run(port=4000)
