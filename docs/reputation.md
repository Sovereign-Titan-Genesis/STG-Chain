# STG-Chain Reputation System (Draft)

## 1. Prinsip Dasar
Reputasi adalah skor kolektif yang mencerminkan kontribusi, kepercayaan, dan aktivitas seseorang di STG-Chain.  
Tujuan:
- Memberi insentif bagi kontribusi positif.
- Menjadi dasar voting power dalam governance.
- Menjadi syarat akses layanan tertentu (lending, sertifikasi, dll).

---

## 2. Sumber Reputasi
Reputasi dihitung dari beberapa sumber:
- **Verifiable Credentials (VC)**: setiap VC valid menambah poin reputasi.
- **On-chain Activity**: transaksi, partisipasi voting, staking.
- **Attestations**: validasi dari pihak ketiga.
- **Community Contributions**: misalnya publikasi, proyek, atau bantuan sosial.

---

## 3. Formula Reputasi
Skor reputasi dihitung dengan bobot:



\[
R = \gamma \cdot VC + \delta \cdot Activity + \epsilon \cdot Attestation + \zeta \cdot Contribution
\]



- γ = bobot VC (misalnya 0.4)  
- δ = bobot aktivitas (0.2)  
- ε = bobot attestations (0.3)  
- ζ = bobot kontribusi komunitas (0.1)

---

## 4. Decay & Anti-Sybil
- **Decay**: reputasi menurun 1% per bulan jika tidak ada aktivitas baru, agar skor tetap relevan.  
- **Anti-Sybil**: reputasi hanya valid jika VC berasal dari issuer dengan reputasi tinggi, dan aktivitas diverifikasi.  

---

## 5. Level Reputasi
Reputasi dibagi dalam level:
- **0–100**: Pemula  
- **101–500**: Kontributor  
- **501–1000**: Validator komunitas  
- **1001+**: Guardian  

Level ini menentukan hak akses governance dan reward multiplier.

---

## 6. Reward & Insentif
- **Multiplier Reward**: reputasi tinggi memberi bonus reward staking/attestation.  
- **Access Control**: reputasi tertentu diperlukan untuk mengajukan proposal governance.  
- **Social Recognition**: reputasi tercatat publik sebagai bukti kontribusi.

---

## 7. Roadmap Implementasi
- **Tahap 1**: reputasi dari VC valid (MVP).  
- **Tahap 2**: reputasi dari aktivitas on-chain (staking, voting).  
- **Tahap 3**: reputasi dari kontribusi komunitas off-chain (via oracles).  
- **Tahap 4**: reputasi lintas ekosistem DApps.

