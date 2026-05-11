# 💼 Investor Portal Specification – Sovereign Titan Genesis

Dokumen ini menetapkan spesifikasi **Investor Portal**, sebuah akses khusus bagi investor untuk memantau token supply, ROI tracker, dan buyback program.  
Portal ini berfungsi sebagai jembatan transparansi antara STG‑Chain dan investor seed.

---

## 📜 Komponen Portal

### 1. Token Supply Monitor
- **Source:** `database/token_supply/`
- **Features:**
  - Real‑time circulating supply
  - Hard cap (1,000T QSTATE)
  - Allocation breakdown (Seed, Humanity Fund, Treasury, Reserve)
- **Visual:** Pie chart + supply counter

### 2. ROI Tracker
- **Source:** `database/roi_data/`
- **Features:**
  - Initial investment amount
  - Current token valuation
  - Projected ROI (Year 1–3)
  - Historical performance graph
- **Visual:** Line chart + ROI calculator widget

### 3. Buyback Program Panel
- **Source:** `governance/buyback/`
- **Features:**
  - Active buyback rounds
  - Buyback price per token
  - Total tokens repurchased
  - Next scheduled buyback date
- **Visual:** Timeline + progress bar

### 4. Investor Reports
- **Source:** `database/investor_reports/`
- **Features:**
  - Quarterly financial reports
  - Proof of Reserve (PoR) documentation
  - Compliance certificates
- **Visual:** Downloadable PDF/CSV

---

## 🔐 Diagram UI Layout (ASCII Mockup)

+-------------------------------------------------------------+
| 💼 Investor Portal                                          |
+----------------+----------------+----------------+----------+
| Token Supply   | ROI Tracker    | Buyback Panel  | Reports  |
| Monitor        | Line Chart     | Timeline       | PDF/CSV  |
| Pie Chart      | ROI Calculator | Progress Bar   | Download |
+----------------+----------------+----------------+----------+



---

## ⚖️ Integration Principles

- **Secure Access:** Portal hanya dapat diakses oleh investor seed dengan autentikasi wallet.  
- **Real‑Time Sync:** Data feed otomatis dari database STG‑Chain.  
- **Immutable Records:** Semua laporan tersimpan permanen di ledger.  
- **Export Options:** PDF/CSV untuk analisis eksternal.  

---

## 📂 Commit Log

```bash
git add docs/INVESTOR_PORTAL_SPEC.md
git commit -m "TRANSPARENCY: Added Investor Portal Specification"
git push origin master


