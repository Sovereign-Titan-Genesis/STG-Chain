# STG-Chain End-to-End Reputation Flow

## 1. Alur Utama
1. **DID Creation**  
   - User membuat DID melalui wallet agent.  
   - DID Document disimpan terenkripsi di IPFS.  

2. **VC Issuance**  
   - Issuer mengeluarkan Verifiable Credential (VC) untuk DID.  
   - Hash VC di-anchor ke chain.  

3. **Reputation Scoring**  
   - Smart contract reputasi membaca VC valid.  
   - Skor reputasi dihitung dengan formula bobot (VC, aktivitas, attestations, kontribusi).  

4. **Reward Distribution**  
   - Tokenomics module menggunakan skor reputasi sebagai multiplier reward staking/attestation.  
   - User dengan reputasi tinggi mendapat reward lebih besar.  

5. **Governance Integration**  
   - Governance module menggunakan reputasi sebagai faktor voting power.  
   - Proposal hanya bisa diajukan oleh DID dengan reputasi minimum.  

---

## 2. Diagram Alur (teks)
[User Wallet Agent]
|
v
Create DID
|
v
[Issuer Service] ---> Issue VC ---> Anchor Hash On-Chain
|
v
[Reputation Contract] ---> Calculate Score ---> Store Reputation
|
v
[Tokenomics Module] ---> Apply Reward Multiplier
|
v
[Governance Module] ---> Voting Power & Proposal Access

---

## 3. Tabel Ringkas

| Tahap              | Input                        | Output                        | Modul Terkait                  |
|--------------------|------------------------------|-------------------------------|--------------------------------|
| DID Creation       | Public key, controller       | DID Document, DID             | SOUL-ID, Wallet Agent          |
| VC Issuance        | DID, claim                   | VC + anchor hash              | Issuer Service, Identity Module|
| Reputation Scoring | VC valid, aktivitas          | Skor reputasi DID             | Reputation Contract            |
| Reward Distribution| Skor reputasi, staking data  | Reward multiplier             | Tokenomics Module              |
| Governance         | Skor reputasi, stake         | Voting power, proposal access | Governance Module              |

---

## 4. Roadmap Implementasi
- **Tahap 1**: DID → VC → reputasi dasar.  
- **Tahap 2**: reputasi multiplier untuk reward.  
- **Tahap 3**: reputasi sebagai voting power.  
- **Tahap 4**: reputasi lintas DApps & oracles.
- 

