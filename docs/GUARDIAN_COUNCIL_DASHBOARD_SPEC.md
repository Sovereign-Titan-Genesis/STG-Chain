# 🏛️ Guardian Council Dashboard Specification – Sovereign Titan Genesis

Dokumen ini menetapkan spesifikasi tampilan visual **Guardian Council Dashboard**.  
Dashboard berfungsi sebagai antarmuka utama untuk memantau status multi‑sig, veto, dan eksekusi transaksi besar di STG‑Chain.

---

## 📜 Komponen Dashboard

### 1. Multi‑Sig Status
- **Source:** `database/multisig_logs/`
- **Display:** Tabel real‑time dengan kolom:
  - Transaction ID
  - Guardian Signatures (Yes/No)
  - Threshold Status (e.g., 3/5 signatures)
  - Current Phase (Pending / Timelock / Executed)

### 2. Veto Panel
- **Visual:** Panel khusus untuk Founder Veto
- **Fields:**
  - Transaction Hash
  - Veto Status (Active/Inactive)
  - Reason for Veto
  - Timestamp
- **Integration:** Linked ke governance repo untuk audit trail

### 3. Execution Monitor
- **Visual:** Timeline status eksekusi transaksi
- **Phases:**
  - Proposal → Guardian Review → Multi‑Sig Signing → Timelock → Execution
- **Data Source:** Multi‑Sig workflow engine
- **Update Interval:** Real‑time (≤ 5 detik)

---

## 🔐 Diagram UI Layout (ASCII Mockup)
+-------------------------------------------------------------+
| 🏛️ Guardian Council Dashboard                               |
+----------------------+----------------------+----------------+
| Multi-Sig Status | Veto Panel | Execution Flow |
| --- | --- | --- |
| TxID | Signatures | TxHash | Veto Status | Proposal |
| ----- | -------------- | ------- | ------------ | Guardian Review |
| 001 | 3/5 (Threshold) | ... | Inactive | Multi-Sig |
| 002 | 2/5 (Pending) | ... | Active | Timelock |
| ... | ... | ... | ... | Execution |
+----------------------+----------------------+----------------+


---

## ⚖️ Governance Integration

- **Multi‑Sig Council Charter:** Dashboard menampilkan status Guardian sesuai Charter.  
- **Sentinel AI Oversight:** Alert dari Sentinel ditampilkan berdampingan untuk konteks risiko.  
- **Audit Trail:** Semua tanda tangan dan veto dicatat permanen di ledger.  

---

## 📂 Commit Log

```bash
git add docs/GUARDIAN_COUNCIL_DASHBOARD_SPEC.md
git commit -m "GOVERNANCE: Added Guardian Council Dashboard Specification"
git push origin master

