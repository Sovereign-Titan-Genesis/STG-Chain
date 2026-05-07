import hashlib
import json

def verify_vc(vc_json):
    try:
        vc = json.loads(vc_json)
        # cek struktur minimal
        if "credentialSubject" not in vc or "proof" not in vc:
            return {"valid": False, "reason": "Invalid structure"}
        # cek hash
        recomputed = hashlib.sha256(vc_json.encode()).hexdigest()
        if vc.get("hash") != recomputed:
            return {"valid": False, "reason": "Hash mismatch"}
        # cek signature (dummy)
        if vc["proof"]["signatureValue"] != "dummy-signature":
            return {"valid": False, "reason": "Invalid signature"}
        return {"valid": True}
    except Exception as e:
        return {"valid": False, "reason": str(e)}
      
