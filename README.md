# ✨ STG-Chain Showcase

**Sovereign Titan Genesis** — ekosistem berdaulat yang menggabungkan finansial, teknologi, lingkungan, dan hukum untuk ketahanan komunitas pesisir.

---

### Ringkasan Proyek
**STG-Chain** adalah repositori kanonikal yang menampung integrasi pilar-pilar STG: identitas digital, infrastruktur pembayaran, produksi pangan berkelanjutan, keamanan otonom, dan layanan publik. Dokumentasi ini menuntun kontributor dan pemangku kepentingan untuk memahami arsitektur, workflows, dan artefak operasional.

---

### 12 Pilar STG
| Pilar | Repo |
| --- | --- |
| **Brain & Identity** | [Sovereign‑Titan‑Genesis](https://github.com/bswcorp/Sovereign-Titan-Genesis) |
| **Digital Soul** | [Titan‑Psyche‑Mono](https://github.com/bswcorp/TITAN-PSYCHE-MONO) |
| **Bridge RWA** | [Metaportation](https://github.com/bswcorp/METAPORTATION) |
| **Event Nervous System** | [STG‑Metaportation‑Event](https://github.com/bswcorp/STG-METAPORTATION-EVENT) |
| **Consensus & Governance** | [Quorum‑State](https://github.com/bswcorp/Quorum-State) |
| **Guardian Intelligence** | [QS Guardian Search](https://github.com/bswcorp/qs-guardian-search) |
| **Native Coin & Liquidity** | [Qubicoin](https://github.com/bswcorp/Qubicoin) |
| **Swap Engine** | [Quantum Swap Engine](https://github.com/bswcorp/quantum-swap-engine) |
| **Sandbox & Labs** | [Garage](https://github.com/bswcorp/Garage) |
| **Act Ark Social Ecology** | [Makronesia Act‑Ark](https://github.com/bswcorp/Makronesia-Act-Ark) |
| **AI Intelligence** | [STG‑1AI](https://github.com/bswcorp/STG-1AI) |
| **Public Services** | [Jasawan](https://github.com/bswcorp/Jasawan) |

---

### Sovereign Manifesto
**Motto**  
*Sovereign fintech turning crises into opportunity.*

**Prinsip Inti**
- **Native Asset Supremacy** — aset asli STG sebagai dasar kedaulatan.
- **Gas Fee Independence** — biaya operasi minimal dan terprediksi.
- **AI Powered** — otomasi dan verifikasi oleh Bio‑Server.

---

### Sistem Kunci
**Bank Resolver**  
- **Fungsi**: memetakan nomor telepon atau VA ke provider dan nama bank/wallet.  
- **Manfaat**: mencegah salah kirim, mempercepat pencairan AKSA → IDR.  
- **Lokasi log**: `BANK_RESOLVER.md`.

**STG-Pay**  
- **Fungsi**: pembayaran real‑time di Bio‑Store via Bio‑Passport scan.  
- **Audit**: semua transaksi dicatat di `STG_PAY_LOG.md`.

**Bio-Reactor Node-Alpha**  
- **Fungsi**: produksi protein organik berbasis OTEC dan alga.  
- **Output**: protein untuk distribusi ke Bio‑Store; produksi dipantau di `BIO_PRODUCTION_LOG.md`.

**Bio-Store Node-Alpha**  
- **Fungsi**: toko fisik kedaulatan untuk penukaran AKSA dengan barang nyata.  
- **Integrasi**: stok live di `MARKET_STATUS.md` dan transaksi via STG‑Pay.

**Security Patrol**  
- **Fungsi**: patroli drone Sentinel‑Wing; log keamanan di `SECURITY_LOG.md`.  
- **Hukum**: aturan udara dan sanksi tercatat di `apps/stg-pilar/law/drone_law.txt`.

## 🚚 Drone Logistics
STG deploys Sentinel-Wing drones for distribution:
- Protein, rice, medicine, energy delivered every 6 hours
- Audit trail logged in LOGISTICS_LOG.md
- Secure routes via Jalur Senyap

 ## 🗺️ Drone Logistics Dashboard
Interactive dashboard showing real-time distribution:
- Protein, rice, medicine, energy flows
- Updated every 15 minutes
- Secure routes monitored by Sentinel-Wing
- Audit trail logged in STG-Chain

View dashboard: [Drone Logistics Dashboard](public/dashboard/index.html)

 ## 🌱 Carbon Ledger & ESG Dashboard
STG tracks environmental contributions:
- Daily CO2 reduction logged
- Bio-Reactor protein offsets
- OTEC green energy integration
- Verified by Bio-Server

View carbon ledger: [Carbon Ledger](CARBON_LEDGER.md)

## 🌍 Global Benchmark Dashboard
STG compares its progress with global leaders:
- Daily food production vs China, India, ASEAN
- ESG score comparison
- Quantum readiness status
- Updated daily

View benchmark: [Global Benchmark Report](GLOBAL_BENCHMARK.md)

---

### Workflows dan Dashboard
**Workflows utama** (lokasi: `.github/workflows/`)  
- `manifesto-qday.yml` — publikasi manifesto Q‑Day.  
- `dashboard-welfare.yml` — Welfare Dashboard.  
- `distribution.yml` — distribusi AKSA ke wallet warga.  
- `distribution-goods.yml` — distribusi beras, obat, energi.  
- `bio-store.yml` — laporan Bio‑Store.  
- `security-patrol.yml` — log patroli drone.  
- `bio-marketplace.yml` — update stok marketplace.  
- `bank-resolver.yml` — sinkronisasi resolver DB.  
- `stg-pay.yml` — pencatatan transaksi STG‑Pay.  
- `bio-reaktor-env.yml` — monitoring produksi Bio‑Reactor.  
- `drone-fleet.yml` — inventaris armada drone.

**Cara cepat melihat status**  
- **Dashboard Welfare**: `public/welfare/index.html`  
- **Distribution Dashboard**: `public/welfare/distribution.html`  
- **Goods Dashboard**: `public/welfare/goods.html`  
- **Bio-Store Report**: `reports/bio-store/report.pdf`  
- **Logs**: `STG_PAY_LOG.md`, `BANK_RESOLVER.md`, `BIO_PRODUCTION_LOG.md`, `SECURITY_LOG.md`, `FLEET_LOG.md`

---

### Kontribusi dan Panduan Operasional
**Menambahkan pilar baru**
1. Buat direktori pilar di `apps/stg-pilar/` dengan struktur `eng|fin|env|soc|law|med`.  
2. Tambahkan workflow di `.github/workflows/` dengan nama yang jelas.  
3. Update `README.md` ini dengan tautan ke artefak baru.

**Proses release**
- Gunakan `workflow_dispatch` untuk deploy manual.  
- Semua perubahan dokumentasi wajib di‑commit oleh `CITO-STG-Bot` untuk audit.

---

### Visual Showcase
**Logo dan ikon** tiap repo akan ditempatkan di folder `assets/visuals/` dan ditampilkan di halaman dokumentasi GitHub Pages.

---

**Kontak Operasional**  
- **CITO STG** — cito@stg.internal  
- **Repo Owner** — Sovereign Titan Genesis

