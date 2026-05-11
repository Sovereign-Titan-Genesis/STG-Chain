# 🛡️ Sentinel Dashboard Specification – Sovereign Titan Genesis

Dokumen ini menetapkan spesifikasi tampilan visual **Sentinel AI Dashboard**.  
Dashboard berfungsi sebagai antarmuka utama untuk memantau log anomali, tingkat risiko, dan notifikasi Guardian Council.

---

## 📜 Komponen Dashboard

### 1. Log Feed
- **Source:** `database/sentinel_logs/`
- **Format:** Mengikuti standar [Sentinel Log Format](ca://s?q=Sentinel_Log_Format)
- **Display:** Tabel real‑time dengan kolom:
  - Log ID
  - Timestamp
  - Risk Level
  - Transaction Hash
  - Action Taken

### 2. Risk Meter
- **Visual:** Gauge/thermometer chart dengan 3 zona:
  - Hijau → Level 1 (Minor irregularities)
  - Kuning → Level 2 (Suspicious activity)
  - Merah → Level 3 (Critical anomaly)
- **Data Source:** Sentinel AI risk classification engine
- **Update Interval:** Real‑time (≤ 5 detik)

### 3. Guardian Alerts
- **Notification Panel:** Menampilkan alert aktif yang dikirim ke Guardian Council
- **Fields:**
  - Guardian Notified (Yes/No)
  - Alert Timestamp
  - Linked Transaction Hash
  - Recommended Action (Review / Veto / Proceed)
- **Integration:** Email + Investor Portal sync

---

## 🔐 Diagram UI Layout (ASCII Mockup)
+-------------------------------------------------------------+
| 🛡️ Sentinel AI Dashboard                                    |
+----------------------+----------------------+----------------+

| Log Feed | Risk Meter | Guardian Alerts |
| --- | --- | --- |
| ID | Time | Risk | [Gauge Chart] | Alert # | Time |
| ---- | ------ | ---------- | Green | Yellow | Red | TxHash | Action |
| 01 | 19:15 | Level 2 |  | ... | ... |
| 02 | 19:20 | Level 1 |  | ... | ... |


---

## ⚖️ Security Integration

- **Timelock Guard:** Dashboard menampilkan countdown delay untuk transaksi besar.  
- **Matrix Guard:** Validasi silang node Swiss ↔ Singapore ditampilkan sebagai status indikator.  
- **Audit Trail:** Semua log feed dapat di‑export ke PDF/CSV untuk auditor.

---

## 📂 Commit Log

```bash
git add docs/SENTINEL_DASHBOARD_SPEC.md
git commit -m "SECURITY: Added Sentinel AI Dashboard Specification"
git push origin master


