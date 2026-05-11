# 🏛️ Multi‑Sig Council Charter – Sovereign Titan Genesis

Dokumen ini adalah piagam resmi yang menetapkan struktur dan aturan **Guardian Council** dalam STG‑Chain.  
Multi‑Sig Council berfungsi sebagai lapisan keamanan tertinggi, memastikan setiap transaksi besar hanya dapat dijalankan dengan persetujuan kolektif Guardian.

---

## 📜 Council Composition

- **Founder Seat:** Andi Muhammad Harpianto (CFO/CTO & Co‑Founder STG)  
- **Guardian #1:** First Titan Guardian – Wallet: `0xABCD1234EF567890ABCD1234EF567890ABCD1234`  
- **Guardian #2:** To be appointed  
- **Guardian #3:** To be appointed  
- **Guardian #4:** To be appointed  
- **Guardian #5:** To be appointed  

*(Jumlah minimum Guardian: 5, dengan 1 kursi Founder tetap)*

---

## 🔐 Multi‑Sig Rules

- **Threshold:** 3 of 5 signatures required untuk eksekusi transaksi besar.  
- **Founder Veto:** Founder memiliki hak veto untuk menunda transaksi jika terindikasi risiko sistemik.  
- **Guardian Rotation:** Guardian baru dapat ditambahkan melalui proposal governance dan persetujuan mayoritas.  
- **Immutable Record:** Semua persetujuan dicatat permanen di ledger STG‑Chain.  

---

## ⚖️ Responsibilities

- **Transaction Approval:** Validasi semua transaksi di atas 1M QSTATE.  
- **Audit Oversight:** Meninjau laporan audit triwulanan dan Proof of Reserve.  
- **Emergency Protocol:** Mengaktifkan *Timelock Guard* jika terjadi serangan atau anomali.  
- **Community Representation:** Menjadi suara komunitas dalam governance STG‑Chain.  

---

## 🛡️ Security Layers

- **Timelock Guard:** 24 jam delay untuk transaksi besar sebelum eksekusi.  
- **Matrix Guard:** Validasi silang antar node (Swiss ↔ Singapore).  
- **Sentinel AI:** Monitoring real‑time untuk mendeteksi anomali.  

---

## 📂 Commit Log

```bash
git add docs/MULTISIG_COUNCIL_CHARTER.md
git commit -m "GOVERNANCE: Established Multi-Sig Council Charter"
git push origin master
