# Roadmap Implementasi Smart Contract Reputasi

## Tujuan
Membangun modul reputasi berbasis CosmWasm yang:
- Menghitung skor reputasi dari VC, aktivitas, dan kontribusi.
- Memberi multiplier reward di tokenomics.
- Menjadi faktor voting power di governance.

---

## Tahap 1: Desain & Skeleton
- Buat kontrak CosmWasm `reputation` dengan fungsi dasar:
  - `add_points(did, points)`
  - `query_score(did)`
- Integrasi dengan modul SOUL-ID untuk validasi DID.
- Simpan skor reputasi di state kontrak.

---

## Tahap 2: Integrasi Tokenomics
- Tambahkan fungsi reward multiplier:
  - `calculate_reward(did, base_reward)`
- Hubungkan dengan modul staking untuk menambah reward sesuai reputasi.
- Simulasi distribusi reward (staking + attestation).

---

## Tahap 3: Integrasi Governance
- Modifikasi voting power formula:
  

\[
  VP = \alpha \cdot \frac{stake}{total\_stake} + \beta \cdot \frac{reputation}{max\_reputation}
  \]


- Smart contract reputasi menyediakan API untuk governance module.
- Uji coba proposal lifecycle dengan reputasi sebagai syarat submit.

---

## Tahap 4: Testing & Audit
- Unit test: tambah poin, query skor, reward multiplier.
- Integration test: end-to-end DID → VC → reputasi → reward.
- Audit eksternal untuk keamanan kontrak.

---

## Tahap 5: Deployment
- Deploy di devnet/testnet.
- Distribusi reputasi awal untuk komunitas.
- Monitoring via dashboard analytics.

---

## Tahap 6: Ekspansi
- Tambahkan decay (penurunan reputasi jika tidak aktif).
- Tambahkan reputasi dari kontribusi off-chain (via oracles).
- Integrasi lintas DApps untuk reputasi ekosistem.

---

## Timeline
- **Bulan 1–2**: Skeleton kontrak + integrasi SOUL-ID.
- **Bulan 3–4**: Integrasi tokenomics reward multiplier.
- **Bulan 5–6**: Integrasi governance voting power.
- **Bulan 7–8**: Testing, audit, devnet publik.
- **Bulan 9–12**: Deployment mainnet + ekspansi fitur.
- 
