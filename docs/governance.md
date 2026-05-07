# STG-Chain Governance Model (Draft)

## 1. Prinsip Dasar
STG-Chain menggunakan model governance on-chain yang transparan, partisipatif, dan berbasis reputasi. Tujuannya adalah memastikan keputusan penting diambil secara kolektif oleh komunitas dengan kombinasi stake dan reputasi.

---

## 2. Proposal Lifecycle
1. **Submit Proposal**  
   - Syarat: reputasi ≥ X atau stake ≥ Y.  
   - Proposal berisi deskripsi, parameter, dan dampak.  

2. **Deposit**  
   - Deposit STG diperlukan untuk mencegah spam.  
   - Deposit dikembalikan jika proposal masuk voting.  

3. **Voting**  
   - Periode: 7–14 hari.  
   - Quorum minimal: 40% partisipasi.  
   - Opsi: *Yes*, *No*, *Abstain*, *Veto*.  

4. **Execution**  
   - Proposal yang lolos dijalankan otomatis oleh chain.  
   - Hasil dicatat on-chain sebagai audit trail.

---

## 3. Voting Power Formula
Voting power dihitung dari kombinasi stake dan reputasi:



\[
VP = \alpha \cdot \frac{stake}{total\_stake} + \beta \cdot \frac{reputation}{max\_reputation}
\]



- α = bobot stake (misalnya 0.7)  
- β = bobot reputasi (misalnya 0.3)  
- Dengan formula ini, reputasi memberi pengaruh nyata tanpa mengalahkan stake.

---

## 4. Emergency Governance
- **Emergency Pause**: mayoritas validator dapat menghentikan modul tertentu jika ada bug kritis.  
- **Fast Track Proposal**: jalur cepat untuk upgrade keamanan dengan periode voting lebih singkat.  

---

## 5. Transparansi & Audit
- Semua proposal, voting, dan hasil dicatat on-chain.  
- Audit trail tersedia untuk publik.  
- Governance Sentinel module memantau kepatuhan dan integritas proses.  

---

## 6. Roadmap Governance
- **Tahap 1 (PoA)**: validator inti mengajukan dan memutuskan proposal.  
- **Tahap 2 (PoS)**: stake + reputasi menentukan voting power.  
- **Tahap 3 (Ekosistem)**: integrasi reputasi lintas DApps, reputasi sosial, dan kontribusi komunitas.
- 
