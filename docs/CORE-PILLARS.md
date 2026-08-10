# STG-Chain Core Pillars

Dokumentasi teknis mengenai empat pilar inti yang saling terintegrasi di dalam ekosistem **Sovereign Titan Genesis (STG)**.

Keempat pilar ini memiliki smart contract masing-masing, mencetak aset digital sendiri, dan saling mengikat di bawah payung kesatuan STG-Chain. Sistem ini sedang bertransformasi menuju model operasional yang lebih terstruktur sebagai **Startup The Company of the Future**.

---

## 1. Overview

STG-Chain menggunakan arsitektur multi-pilar. Setiap pilar memiliki tanggung jawab teknis yang jelas dan beroperasi secara modular, namun tetap saling terhubung melalui kontrak dan mekanisme integrasi.

| Pilar | Repository | Token / Aset | Peran Utama |
|-------|------------|--------------|-------------|
| **Qubicoin** | [bswcorp/Qubicoin](https://github.com/bswcorp/Qubicoin) | `$QUBI` | Native coin & unit nilai ekosistem |
| **STG-1AI** | [bswcorp/STG-1AI](https://github.com/bswcorp/STG-1AI) | Token AI Layer | Intelligence & automation engine |
| **Makronesia Act-Ark** | [bswcorp/Makronesia-Act-Ark](https://github.com/bswcorp/Makronesia-Act-Ark) | `$QSTATE` | Governance & decision layer |
| **TITAN-PSYCHE-MONO** | [bswcorp/TITAN-PSYCHE-MONO](https://github.com/bswcorp/TITAN-PSYCHE-MONO) | `114 Absolute Infinite` | Asset & settlement layer |

---

## 2. Arsitektur Integrasi

```text
                    ┌─────────────────────────────────┐
                    │     Sovereign Titan Genesis     │
                    │         (STG-Chain)             │
                    └────────────────┬────────────────┘
                                     │
          ┌──────────────────────────┼──────────────────────────┐
          │                          │                          │
          ▼                          ▼                          ▼
   ┌─────────────┐           ┌─────────────┐           ┌─────────────────┐
   │  Qubicoin   │◄─────────►│  STG-1AI    │◄─────────►│ Makronesia      │
   │  ($QUBI)    │           │ (AI Layer)  │           │ Act-Ark         │
   │ Native Coin │           │             │           │ ($QSTATE)       │
   └──────┬──────┘           └──────┬──────┘           └────────┬────────┘
          │                         │                           │
          └─────────────────────────┼───────────────────────────┘
                                    │
                                    ▼
                       ┌─────────────────────────┐
                       │   TITAN-PSYCHE-MONO     │
                       │ (114 Absolute Infinite) │
                       │  Asset & Settlement     │
                       └─────────────────────────┘


## 3. Detail Pilar (Versi Terkoreksi)

### 3.1 Qubicoin (`$QUBI`)
- **Repository:** [https://github.com/bswcorp/Qubicoin](https://github.com/bswcorp/Qubicoin)
- **Peran:** Native coin ekosistem STG
- **Fungsi utama:** Unit nilai, swap, dan distribusi lintas pilar

### 3.2 STG-1AI
- **Repository:** [https://github.com/bswcorp/STG-1AI](https://github.com/bswcorp/STG-1AI)
- **Peran:** Sovereign Intelligence Engine / AI Layer
- **Fungsi utama:** Orkestrasi data, automation, dan intelligence layer

### 3.3 Makronesia Act-Ark
- **Repository:** [https://github.com/bswcorp/Makronesia-Act-Ark](https://github.com/bswcorp/Makronesia-Act-Ark)
- **Peran:** Governance & Resource Layer
- **Catatan Token:**  
  Makronesia Act-Ark **tidak** menggunakan ticker `$QSTATE`.  
  Token native-nya berbeda (silakan dilengkapi ticker resminya jika sudah tersedia).

### 3.4 TITAN-PSYCHE-MONO (`114 Absolute Infinite`)
- **Repository:** [https://github.com/bswcorp/TITAN-PSYCHE-MONO](https://github.com/bswcorp/TITAN-PSYCHE-MONO)
- **Peran:** Asset & Settlement Layer

---

### Informasi Token $QSTATE (Quorum-State)

| Item | Detail |
|------|--------|
| **Nama Proyek** | Quorum-State Int’l |
| **Ticker** | `$QSTATE` |
| **Repository** | [https://github.com/bswcorp/Quorum-State](https://github.com/bswcorp/Quorum-State) |
| **Network** | Arbitrum Mainnet |
| **Contract Address** | `0x44Fbc1734Fb17c1902A84ECb443eF4067d950A47` |
| **Peran dalam Ekosistem** | Governance / Consensus related token (terpisah dari Makronesia Act-Ark) |
