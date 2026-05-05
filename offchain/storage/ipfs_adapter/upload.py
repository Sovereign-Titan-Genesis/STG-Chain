import ipfshttpclient
from encryption import encrypt_payload

def upload_encrypted(payload: dict, owner_pubkey: str):
    ciphertext, meta = encrypt_payload(payload, owner_pubkey)
    client = ipfshttpclient.connect()
    res = client.add_bytes(ciphertext)
    cid = res
    return {"cid": cid, "meta": meta}
  
