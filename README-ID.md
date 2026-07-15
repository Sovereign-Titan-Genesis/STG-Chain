# STG-Rantai

STG-Chain adalah lapisan inti blockchain Layer-2 dalam ekosistem STG.
Fokus utama: **sequencer**, **state manager**, dan **storage backend**.

## ✨ Fitur Utama
- Sequencer untuk mengatur urutan transaksi dan batching ke Layer-1.
- State manager untuk menyimpan status akun, kontrak, dan transaksi.
- Penyimpanan backend berbasis Postgres/RocksDB.
- Integrasi langsung dengan modul konsensus (STG-CONSESUS).

## 📂 Struktur
- `sequencer/` → modul sequencer & manajer batch.
- `state/` → manajemen state & database.
- `buruh pelabuhan/` → konfigurasi devnet/testnet lokal.

## Modul 📘 Menjalankan README Modul Strike
# Modul Taruhan STG-QSTATE

Modul ini mendefinisikan mekanisme staking untuk token QSTATE pada jaringan STG Testnet (Sepolia).
Tujuan utama: menjaga keamanan jaringan, memberikan insentif validator, dan memastikan tata kelola berbasis partisipasi.

---

## ✨ Fitur Utama
- **Deposit & Lock**: Token QSTATE dikunci dalam kontrak `StgStakePool.sol`.
- **Reward**: Validator menerima reward otomatis setiap epoch.
- **Slashing**: Validator yang gagal uptime atau melanggar aturan akan kehilangan sebagian stake.
- **Governance**: Token yang di-stake memberikan hak suara dalam proposal tata kelola.

---

## 📂 Struktur Folder & File

### STG-Rantai
contract/ └── StgStakePool.sol # Kontrak staking utama state/ └── staking_state.rs # Manajemen state staking

### STG-web3
rpc/handlers/ └── staking.ts # Endpoint RPC untuk query status staking sdk/js/ └── staking.ts # SDK JS untuk interaksi staking

---

## 🚀 Cara Berlari
1. Deploy kontrak `StgStakePool.sol` ke jaringan Sepolia.
2. Tambahkan alamat kontrak ke **Master Registry** di `STG-DOCUMENTATION-STANDARD.md`.
3. Jalankan node STG-Chain dengan modul staking aktif.
4. Gunakan STG-web3 RPC untuk memanggil fungsi:
- `taruhan(jumlah)`
- `klaimReward()`
- `batalkan taruhannya()`
5. Validator diverifikasi melalui modul `staking_verifier.rs` di STG-Consensus.

---

## 🔒 Keamanan
- Audit kontrak staking sebelum migrasi ke mainnet.
- Gunakan dompet testnet untuk uji coba, jangan gunakan dana nyata.
- Mekanisme slashing otomatis untuk menjaga integritas validator.

---

## 🤝 Kontribusi
- Ikuti standar dokumentasi di `STG-DOCUMENTATION-STANDARD.md`.
- Tambahkan test unit di setiap modul (`tests/`).
- Semua PR wajib menyertakan bukti integrasi dengan Master Registry.

## Modul Tambahan
- [Mempertaruhkan QSTATE](README-STAKING.md)


## 🚀 Peta Jalan
- v0.1 → Devnet internal.
- v0.2 → Testnet publik dengan faucet.
- v1.0 → Mainnet dengan validator terdistribusi.

## 🔒 Keamanan
Audit internal & eksternal sebelum peluncuran mainnet.

## 🤝 Kontribusi
Lihat [KONTRIBUSI.md](KONTRIBUSI.md).


# ✨ STG‑Chain Showcase: 12 Pilar

Inilah wajah resmi 12 Pilar yang membentuk ekosistem berdaulat STG‑Chain.

## 🧠 OTAK & IDENTITAS
- [Sovereign‑Titan‑Genesis](https://github.com/bswcorp/Sovereign-Titan-Genesis) — Konstitusi & Identitas Induk
- [Titan‑Psyche‑Mono](https://github.com/bswcorp/TITAN-PSYCHE-MONO) — Jiwa Digital & Manajemen Negara

## 🌉 JEMBATAN
- [Metaportasi](https://github.com/bswcorp/METAPORTATION) — Gerbang ATMR
- [STG‑Metaportation‑Event](https://github.com/bswcorp/STG-METAPORTATION-EVENT) — Acara Sistem Syaraf

## 🛡️ PEMBELA
- [Quorum‑State](https://github.com/bswcorp/Quorum-State) - Konsensus & Tata Kelola
- [Pencarian Penjaga QS](https://github.com/bswcorp/qs-guardian-search) — Kepatuhan Intelijen

## 💰 PEREKONOMIAN
- [Qubicoin](https://github.com/bswcorp/Qubicoin) — Koin & Likuiditas Asli
- [Quantum Swap Engine](https://github.com/bswcorp/quantum-swap-engine) — Pertukaran Instan

## 🗄️ SUMBER DAYA & PENYIMPANAN
- [Garasi](https://github.com/bswcorp/Garage) — Eksperimen Sandbox
- [Makronesia Act‑Ark](https://github.com/bswcorp/Makronesia-Act-Ark) — Ekologi Sosial & Aset Hijau

## 🤖 KECERDASAN & PELAYANAN
- [STG‑1AI](https://github.com/bswcorp/STG-1AI) — Kecerdasan AI 5 Tahap
- [Jasawan](https://github.com/bswcorp/Jasawan) — Layanan Publik & Identitas Teritorial

---
## 🛡️ Manifesto Kedaulatan
*"Fintech yang berdaulat mengubah krisis menjadi peluang."*
- Supremasi Aset Asli
- Kemandirian Biaya Gas
- Didukung AI&Saya

## 📸 Etalase Visual

| Pilar | Logo |
|-------|------|
| Sovereign‑Titan‑Genesis | ![Logo Kejadian](assets/genesis.png) |
| Metaportasi | ![Logo Metaportasi](assets/metaportation.png) |
| Negara Bagian Siapa | ![Logo Kuorum](aset/kuorum.png) |
| Pencarian Wali QS | ![Logo Penjaga](assets/guardian.png) |
| Titan Jiwa Mono | ![Logo Jiwa](assets/psyche.png) |
| STG‑Metaportasi‑Acara | ![Logo Acara](aset/acara.png) |
| Qubicoin | ![Logo Qubicoin](assets/qubicoin.png) |
| Undang-Undang Makronesia‑Tabut | ![Logo Makronesia](assets/makronesia.png) |
| Garasi | ![Logo Garasi](assets/garage.png) |
| STG‑1AI | ![Logo 1AI](assets/1ai.png) |
| Mesin Pertukaran Kuantum | ![Logo Tukar](aset/swap.png) |
| Jasawan | ![Jasawan Logo](assets/jasawan.png) |
## 🟢 Lencana Status Kesehatan

| Pilar | Status |
|-------|--------|
| Sovereign‑Titan‑Genesis | ![Status Kejadian](https://img.shields.io/badge/status-passing-brightgreen) |
| Metaportasi | ![Status Metaportasi](https://img.shields.io/badge/status-passing-brightgreen) |
| Kuorum‑Negara Bagian | ![Status Kuorum](https://img.shields.io/badge/status-passing-brightgreen) |
| Pencarian Wali QS | ![Status Wali](https://img.shields.io/badge/status-passing-brightgreen) |
| Titan Jiwa Mono | ![Status Jiwa](https://img.shields.io/badge/status-passing-brightgreen) |
| STG‑Metaportasi‑Acara | ![Status Acara](https://img.shields.io/badge/status-passing-brightgreen) |
| Qubicoin | ![Status Qubicoin](https://img.shields.io/badge/status-passing-brightgreen) |
| Undang-Undang Makronesia‑Tabut | ![Status Makronesia](https://img.shields.io/badge/status-passing-brightgreen) |
| Garasi | ![Status Garasi](https://img.shields.io/badge/status-passing-brightgreen) |
| STG‑1AI | ![Status 1AI](https://img.shields.io/badge/status-passing-brightgreen) |
| Mesin Pertukaran Kuantum | ![Status Tukar](https://img.shields.io/badge/status-passing-brightgreen) |
| Jasawan | ![Status Jasawan](https://img.shields.io/badge/status-passing-brightgreen) |
