# 🏛️ Council Governance Workflow – Sovereign Titan Genesis

Dokumen ini menjelaskan alur kerja **Multi‑Sig Guardian Council** dalam memvalidasi transaksi besar di STG‑Chain.  
Workflow ini memastikan bahwa tidak ada satu tangan pun yang dapat menggerakkan Giant tanpa persetujuan kolektif.

---

## 📜 Alur Persetujuan Transaksi

1. **Proposal Transaction**
   - Founder atau node resmi mengajukan transaksi (misalnya transfer > 1M QSTATE).
   - Proposal dicatat di ledger sebagai *Pending Transaction*.

2. **Guardian Review**
   - Guardian Council menerima notifikasi proposal.
   - Setiap Guardian melakukan verifikasi independen (audit, compliance, risk check).

3. **Multi‑Sig Signing**
   - Minimal **3 dari 5 Guardian** menandatangani transaksi.
   - Founder memiliki hak veto untuk menunda jika terindikasi risiko sistemik.

4. **Timelock Guard**
   - Setelah threshold tercapai, transaksi masuk fase *Timelock* (24 jam delay).
   - Memberi waktu komunitas dan Sentinel AI untuk mendeteksi anomali.

5. **Execution**
   - Setelah timelock berakhir tanpa veto, transaksi dieksekusi di STG‑Chain.
   - Status berubah menjadi *Confirmed Transaction*.

6. **Audit Trail**
   - Semua tanda tangan, hash, dan timestamp dicatat permanen di ledger.
   - Laporan otomatis dikirim ke *Investor Portal* dan *Governance Dashboard*.

---

## 🔐 Diagram Alur (ASCII Flow)

[ Proposal Transaction ]
|
v
[ Guardian Review ]
|
v
[ Multi-Sig Signing ] --(>=3 signatures)--> [ Timelock Guard (24h) ]
|                                      |
|                                      v
|                               [ Sentinel AI Check ]
|                                      |
v                                      v
[ Founder Veto ] ------------------> [ Execution on STG-Chain ]
|
v
[ Audit Trail Recorded ]
