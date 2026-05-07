# STG-Chain Architecture (Draft)

## 1. Konsensus
- **Tahap awal (PoA)**: validator terbatas, berbasis identitas & reputasi. Cocok untuk devnet/testnet.
- **Migrasi ke PoS**: setelah komunitas tumbuh, stake STG token menjadi syarat validator. Desentralisasi lebih luas.

---

## 2. Node Roles
- **Validator**: menjalankan konsensus, memvalidasi blok, mengeluarkan attestations.
- **Delegator**: men‑stake token ke validator, menerima reward.
- **Issuer**: pihak yang mengeluarkan VC, menulis anchor hash ke chain.
- **Verifier**: memverifikasi VC, reputasi, dan revocation registry.
- **User/Wallet Agent**: membuat DID, menyimpan VC, berpartisipasi dalam governance.

---

## 3. Modul Integrasi
- **SOUL-ID Module**: DID registry, VC, attestations.
- **Reputation Module**: skor reputasi dari VC & aktivitas.
- **Token Module**: STG token, staking, reward.
- **Governance Module**: proposal, voting, quorum.
- **Bridge Module**: integrasi ke chain eksternal (Ethereum, Cosmos).

---

## 4. Arsitektur Layer
- **Application Layer**: wallet agent, issuer/verifier services, DApps.
- **Module Layer**: identity, reputation, token, governance.
- **Consensus Layer**: PoA → PoS.
- **Networking Layer**: Tendermint/Cosmos SDK p2p.
- **Storage Layer**: on‑chain KV store + off‑chain IPFS/Arweave.

---

## 5. Roadmap Migrasi
- **Devnet**: PoA, validator inti.
- **Testnet**: PoA + reputasi module.
- **Mainnet awal**: PoA → PoS hybrid.
- **Mainnet penuh**: PoS, stake + reputasi menentukan validator set.
- 
