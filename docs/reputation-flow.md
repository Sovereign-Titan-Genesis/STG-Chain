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

