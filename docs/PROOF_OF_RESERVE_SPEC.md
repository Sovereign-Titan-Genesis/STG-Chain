# 🏦 Proof of Reserve (PoR) Specification – Sovereign Titan Genesis

Dokumen ini menetapkan standar verifikasi **Proof of Reserve (PoR)** untuk STG‑Chain.  
Tujuan utama: memastikan aset pendukung tercatat, diverifikasi, dan dapat diaudit secara publik tanpa membuka detail saldo penuh.

---

## 📜 Komponen Proof of Reserve

### 1. Reserve Metadata
- **Source:** `database/proof_of_reserve/`
- **Fields:**
  - Reserve ID
  - Asset Type (Fiat, Crypto, Physical)
  - Location (Vault/Node)
  - Custodian
  - Timestamp

### 2. Cryptographic Hash
- **Algorithm:** SHA‑256
- **Purpose:** Menghasilkan hash unik dari data cadangan
- **Format:** Hexadecimal string
- **Example:**

  9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08

  
### 3. Zero‑Knowledge Proof (ZKP)
- **Protocol:** zk‑SNARKs / Bulletproofs
- **Purpose:** Membuktikan solvabilitas tanpa membuka saldo penuh
- **Deliverable:** `proof.json` file dengan verifikasi pihak ketiga

### 4. RSA Signature
- **Key:** Public key STG‑Chain Governance
- **Purpose:** Menandatangani laporan PoR agar tidak dapat dimanipulasi
- **Deliverable:** `signature.pem`

---

## 🔐 JSON Schema

```json
{
"reserve_id": "string",
"asset_type": "string (fiat, crypto, physical)",
"location": "string",
"custodian": "string",
"timestamp": "string (UTC)",
"hash": "string (SHA-256)",
"zkp_proof": "string (file reference)",
"rsa_signature": "string (file reference)"
}
