# STG-Chain Reputation Simulation

## Tujuan
Memberikan contoh konkret bagaimana reputasi dari DID memengaruhi reward multiplier dan voting power dalam governance.

---

## Simulasi Per DID

| DID   | VC Valid | Skor Reputasi | Reward Multiplier | Stake (STG) | Voting Power (%) |
|-------|----------|---------------|-------------------|-------------|-----------------|
| DID A | 3        | 200           | 1.2x              | 10,000      | 5%              |
| DID B | 5        | 450           | 1.5x              | 20,000      | 12%             |
| DID C | 1        | 80            | 1.0x              | 5,000       | 2%              |
| DID D | 8        | 900           | 1.8x              | 50,000      | 25%             |
| DID E | 2        | 150           | 1.1x              | 8,000       | 4%              |

---

## Formula yang Digunakan
- **Reward Multiplier**:  
  

\[
  M = 1 + \frac{Reputasi}{1000}
  \]

  
  (contoh: reputasi 200 → multiplier 1.2x)

- **Voting Power**:  
  

\[
  VP = \alpha \cdot \frac{stake}{total\_stake} + \beta \cdot \frac{reputation}{max\_reputation}
  \]

  
  dengan α=0.7, β=0.3.

---

## Insight
- DID dengan reputasi tinggi (DID D) mendapat multiplier reward besar dan voting power dominan.  
- DID dengan reputasi rendah (DID C) tetap bisa berpartisipasi, tetapi pengaruhnya kecil.  
- Kombinasi stake + reputasi menjaga keseimbangan antara kekuatan finansial dan kontribusi sosial.  

---

## Roadmap Simulasi
- **Tahap 1**: simulasi sederhana (VC valid → reputasi → multiplier).  
- **Tahap 2**: integrasi staking data nyata dari testnet.  
- **Tahap 3**: simulasi governance proposal dengan reputasi threshold.
- 
