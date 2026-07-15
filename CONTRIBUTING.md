# Contributing to STG-Chain

Welcome to **Sovereign Titan Genesis (STG-Chain)**.  
This project is sovereign, mandiri, and berdaulat. Contributions are welcome, but must respect the principles of sovereignty and compliance.

---

## 📜 Contribution Rules

1. **License Compliance**
   - All contributions are governed by the **STG-PURE-MANDIRI LICENSE**.
   - Contributors agree not to claim ownership or exclusive rights over STG-Chain.

2. **Sovereign Notice**
   - Every pull request must include attribution to STG-Chain.
   - Derivative works must reference the original repository.

3. **Code Standards**
   - Use clear commit messages: `[module] action — short description`.
   - Run lint and tests before submitting PRs.
   - No secrets, private keys, or sensitive data may be committed.

4. **Governance**
   - Major changes (protocol, consensus, tokenomics) require governance proposal.
   - Governance proposals must be approved by validator quorum (Kesebelasan Naga).

5. **Compliance**
   - Contributions must not introduce code that circumvents KYC/AML or audit mechanisms.
   - Contributors must respect applicable laws and regulations.

---

## 🛠️ How to Contribute

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature/my-feature`.
3. Make your changes and commit with proper headers.
4. Push to your fork and open a Pull Request.
5. Await review by maintainers and governance approval.

---

# CONTRIBUTING — STG-QSTATE Staking Module

Terima kasih atas kontribusi Anda pada modul staking STG-QSTATE.  
Dokumen ini menetapkan standar kontribusi agar kode, dokumentasi, dan pengujian konsisten dengan filosofi STG:  
> "Code follows Governance, Governance follows Values."

---

## 🧩 Ruang Lingkup
Modul staking mencakup:
- Kontrak `StgStakePool.sol` di **STG-Chain**
- Verifikasi staking & slashing di **STG-Consensus**
- Endpoint RPC & SDK di **STG-web3**

---

## 📂 Struktur Repo
- **STG-Chain/contracts/StgStakePool.sol** → Kontrak staking utama
- **STG-Consensus/validator/staking_verifier.rs** → Verifikasi proof & slashing
- **STG-web3/rpc/handlers/staking.ts** → Endpoint RPC
- **STG-web3/sdk/js/staking.ts** → SDK interaksi staking

---

## 🛠️ Standar Kontribusi
1. **Coding Style**
   - Solidity: gunakan versi `^0.8.20`, ikuti standar NatSpec.
   - Rust: gunakan `clippy` untuk linting.
   - TypeScript: gunakan `eslint` + `prettier`.

2. **Testing**
   - Tambahkan unit test di folder `tests/`.
   - Semua PR wajib menyertakan hasil test staking (`stake`, `claimReward`, `unstake`).
   - Gunakan dompet testnet, jangan gunakan dana nyata.

3. **Dokumentasi**
   - Setiap fungsi publik wajib memiliki komentar NatSpec.
   - Update `README-STAKING.md` jika ada perubahan API.
   - Tambahkan alamat kontrak baru ke **Master Registry** di `STG-DOCUMENTATION-STANDARD.md`.

4. **Audit & Keamanan**
   - Semua perubahan kontrak wajib melalui audit internal.
   - Mekanisme slashing harus diuji dengan simulasi uptime <95%.
   - Jangan pernah hardcode private key atau mnemonic.

---

## 🔄 Alur Pull Request
1. Fork repo terkait (STG-Chain, STG-Consensus, STG-web3).
2. Buat branch dengan format: `staking/feature-name`.
3. Lakukan perubahan sesuai standar di atas.
4. Tambahkan test & dokumentasi.
5. Ajukan PR dengan deskripsi jelas:
   - Perubahan yang dilakukan
   - Dampak terhadap modul staking
   - Bukti hasil test

---

## 🤝 Etika Kontribusi
- Hormati filosofi STG: integritas, transparansi, keberlanjutan.
- Diskusikan ide besar di forum governance sebelum implementasi.
- Hindari perubahan yang dapat mengganggu kompatibilitas backward.

---

## 📜 Lisensi
Kontribusi pada modul staking tunduk pada lisensi MIT.


## ⚖️ Contributor License Agreement (CLA)

By submitting a contribution, you agree to:
- License your work under the STG-PURE-MANDIRI LICENSE.
- Grant STG-Chain the right to use, modify, and distribute your contribution.
- Acknowledge the sovereignty of STG governance.

---

## 🧭 Contact

For questions, proposals, or governance matters, contact:
- **Sovereign Titan Genesis**  
- Repository: [STG-Chain](https://github.com/Sovereign-Titan-Genesis/STG-Chain)

