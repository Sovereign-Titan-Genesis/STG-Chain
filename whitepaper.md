# STG-Chain Whitepaper (Draft)

## 1. Ringkasan Eksekutif
STG‑Chain adalah blockchain berdaulat yang dibangun untuk mencatat identitas, reputasi, dan kontribusi setiap individu. Visi utamanya: *“Mengubah seseorang tanpa catatan menjadi seseorang dengan catatan terbanyak karena dibantu oleh semua orang.”*

---

## 2. Latar Belakang
- **Masalah**: banyak orang tidak memiliki catatan digital yang dapat diverifikasi (identitas, reputasi, kontribusi).
- **Solusi**: blockchain sebagai ledger kolektif, transparan, dan tidak dapat dimanipulasi.
- **STG‑Chain**: app‑chain berbasis Cosmos SDK dengan modul identitas (SOUL‑ID), reputasi, dan governance.

---

## 3. Arsitektur Teknis
- **Layer Konsensus**: Proof of Authority (PoA) untuk fase awal, migrasi ke Proof of Stake (PoS) untuk desentralisasi penuh.
- **Layer Identitas**: modul SOUL‑ID (DID registry, VC, attestations).
- **Layer Reputasi**: skor reputasi dari VC, aktivitas on‑chain, kontribusi komunitas.
- **Layer Token**: STG token sebagai unit likuiditas berdaulat.
- **Layer Governance**: proposal, voting, quorum, emergency pause.

---

## 4. Roadmap Teknis
- **0–2 bulan**: modul identitas, wallet agent, IPFS & enkripsi.
- **3–6 bulan**: issuer/verifier service, reputasi module.
- **7–10 bulan**: arsitektur chain, tokenomics, CosmWasm contracts.
- **11–14 bulan**: governance model, whitepaper publik.
- **15–18 bulan**: audit, mainnet launch.
- **19–24 bulan**: integrasi eksternal, ekosistem DApps.

---

## 5. Tokenomics
- **Supply total**: 1 miliar STG.
- **Distribusi**:
  - 40% komunitas & contributor (airdrop, reward reputasi).
  - 20% validator & staking pool.
  - 20% treasury & governance.
  - 10% tim inti & developer.
  - 10% cadangan ekosistem (grant, integrasi).
- **Reward model**:
  - Attestation reward: setiap VC valid memberi poin reputasi + reward STG kecil.
  - Staking reward: validator & delegator menerima reward dari inflasi tahunan (±5%).
- **Inflasi**: 5% per tahun, menurun seiring adopsi.
- **Vesting**: tim inti & developer vesting 3 tahun.

---

## 6. Governance Model
- **Proposal lifecycle**: submit → deposit → voting → execution.
- **Voting power**: kombinasi stake + reputasi.
- **Quorum**: minimal 40% partisipasi.
- **Emergency pause**: dapat diaktifkan mayoritas validator jika ada bug kritis.

---

## 7. Use Cases
- Identitas digital berdaulat (SOUL‑ID).
- Reputasi untuk lending, voting, akses layanan.
- Supply chain tracking.
- Sertifikasi pendidikan & kontribusi sosial.

---

## 8. Risiko & Mitigasi
- **Sentralisasi PoA** → migrasi ke PoS.
- **Sybil attack** → kombinasi identitas + stake.
- **Data privasi** → enkripsi off‑chain, selective disclosure.
- **Bug kontrak** → audit eksternal, emergency pause.

---

## 9. Penutup
STG‑Chain adalah fondasi untuk ekosistem digital berdaulat, di mana setiap orang bisa memiliki catatan yang diverifikasi oleh komunitas global.
