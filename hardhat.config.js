require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

/**
 * @title QSDG Chainstack Cloud Connection Configuration
 * @notice Menghubungkan deployment koin utama QSTATE langsung ke satelit Chainstack BSC
 * @author Jenderal Sadewa & Pandawa 5 AI (2026)
 */
module.exports = {
  solidity: "0.8.20",
  networks: {
    // 📡 JALUR UTAMA SATELIT CLOUD SULTAN (Sesuai Foto Dashboard Chainstack)
    chainstack_bsc: {
      // Tempelkan URL HTTPS dari kolom "Akses dan kredensial" Chainstack Sultan di bawah ini:
      url: process.env.RPC_URL || "https://chainstack.com", 
      chainId: 56, // Mengunci mutlak ke ID Rantai Binance Smart Chain Mainnet
      accounts: [process.env.PRIVATE_KEY], // Menarik private key dompet Sultan dari berkas .env
      gasPrice: 3000000000 // Mengunci gas fee stabil 3 Gwei anti-spekulasi bandar luar
    }
  }
};
