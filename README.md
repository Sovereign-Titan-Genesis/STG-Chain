# STG-Chain

STG-Chain adalah lapisan inti blockchain Layer-2 dalam ekosistem STG.  
Fokus utama: **sequencer**, **state manager**, dan **storage backend**.

## ✨ Fitur Utama
- Sequencer untuk mengatur urutan transaksi dan batching ke Layer-1.
- State manager untuk menyimpan status akun, kontrak, dan transaksi.
- Storage backend berbasis Postgres/RocksDB.
- Integrasi langsung dengan modul konsensus (STG-CONSESUS).

## 📂 Struktur
- `sequencer/` → modul sequencer & batch manager.
- `state/` → manajemen state & database.
- `docker/` → konfigurasi devnet/testnet lokal.
  
## Modul 📘 Draf README Modul Staking
# STG-QSTATE Staking Module

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

### STG-Chain
contract/ └── StgStakePool.sol # Kontrak staking utama state/ └── staking_state.rs # Manajemen state staking

### STG-web3
rpc/handlers/ └── staking.ts # Endpoint RPC untuk query status staking sdk/js/ └── staking.ts # SDK JS untuk interaksi staking

---

## 🚀 Cara Menjalankan
1. Deploy kontrak `StgStakePool.sol` ke jaringan Sepolia.
2. Tambahkan alamat kontrak ke **Master Registry** di `STG-DOCUMENTATION-STANDARD.md`.
3. Jalankan node STG-Chain dengan modul staking aktif.
4. Gunakan RPC STG-web3 untuk memanggil fungsi:
   - `stake(amount)`
   - `claimReward()`
   - `unstake()`
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
- [Staking QSTATE](README-STAKING.md)


## 🚀 Roadmap
- v0.1 → Devnet internal.
- v0.2 → Testnet publik dengan faucet.
- v1.0 → Mainnet dengan validator terdistribusi.

## 🔒 Keamanan
Audit internal & eksternal sebelum peluncuran mainnet.

## 🤝 Kontribusi
Lihat [CONTRIBUTING.md](CONTRIBUTING.md).


# ✨ STG‑Chain Showcase: The 12 Pillars

Inilah wajah resmi 12 Pilar yang membentuk ekosistem berdaulat STG‑Chain.

## 🧠 THE BRAIN & IDENTITY
- [Sovereign‑Titan‑Genesis](https://github.com/bswcorp/Sovereign-Titan-Genesis) — Konstitusi & Identitas Induk
- [Titan‑Psyche‑Mono](https://github.com/bswcorp/TITAN-PSYCHE-MONO) — Jiwa Digital & State Management

## 🌉 THE BRIDGE
- [Metaportation](https://github.com/bswcorp/METAPORTATION) — Gerbang RWA
- [STG‑Metaportation‑Event](https://github.com/bswcorp/STG-METAPORTATION-EVENT) — Sistem Syaraf Event

## 🛡️ THE DEFENDER
- [Quorum‑State](https://github.com/bswcorp/Quorum-State) — Konsensus & Tata Kelola
- [QS Guardian Search](https://github.com/bswcorp/qs-guardian-search) — Intelijen Compliance

## 💰 THE ECONOMY
- [Qubicoin](https://github.com/bswcorp/Qubicoin) — Native Coin & Liquidity
- [Quantum Swap Engine](https://github.com/bswcorp/quantum-swap-engine) — Pertukaran Instan

## 🗄️ THE RESOURCE & STORAGE
- [Garage](https://github.com/bswcorp/Garage) — Sandbox Eksperimen
- [Makronesia Act‑Ark](https://github.com/bswcorp/Makronesia-Act-Ark) — Ekologi Sosial & Aset Hijau

## 🤖 THE INTELLIGENCE & SERVICE
- [STG‑1AI](https://github.com/bswcorp/STG-1AI) — AI 5‑Stage Intelligence
- [Jasawan](https://github.com/bswcorp/Jasawan) — Layanan Publik & Identitas Teritorial

---
## 🛡️ Sovereign Manifesto
*"Sovereign fintech turning crises into opportunity."*
- Native Asset Supremacy
- Gas Fee Independence
- AI&Me Powered

## 📸 Visual Showcase

| Pilar | Logo |
|-------|------|
| Sovereign‑Titan‑Genesis | ![Genesis Logo](assets/genesis.png) |
| Metaportation | ![Metaportation Logo](assets/metaportation.png) |
| Quorum‑State | ![Quorum Logo](assets/quorum.png) |
| QS Guardian Search | ![Guardian Logo](assets/guardian.png) |
| Titan Psyche Mono | ![Psyche Logo](assets/psyche.png) |
| STG‑Metaportation‑Event | ![Event Logo](assets/event.png) |
| Qubicoin | ![Qubicoin Logo](assets/qubicoin.png) |
| Makronesia Act‑Ark | ![Makronesia Logo](assets/makronesia.png) |
| Garage | ![Garage Logo](assets/garage.png) |
| STG‑1AI | ![1AI Logo](assets/1ai.png) |
| Quantum Swap Engine | ![Swap Logo](assets/swap.png) |
| Jasawan | ![Jasawan Logo](assets/jasawan.png) |
## 🟢 Health Status Badges

| Pilar | Status |
|-------|--------|
| Sovereign‑Titan‑Genesis | ![Genesis Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Metaportation | ![Metaportation Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Quorum‑State | ![Quorum Status](https://img.shields.io/badge/status-passing-brightgreen) |
| QS Guardian Search | ![Guardian Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Titan Psyche Mono | ![Psyche Status](https://img.shields.io/badge/status-passing-brightgreen) |
| STG‑Metaportation‑Event | ![Event Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Qubicoin | ![Qubicoin Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Makronesia Act‑Ark | ![Makronesia Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Garage | ![Garage Status](https://img.shields.io/badge/status-passing-brightgreen) |
| STG‑1AI | ![1AI Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Quantum Swap Engine | ![Swap Status](https://img.shields.io/badge/status-passing-brightgreen) |
| Jasawan | ![Jasawan Status](https://img.shields.io/badge/status-passing-brightgreen) |
