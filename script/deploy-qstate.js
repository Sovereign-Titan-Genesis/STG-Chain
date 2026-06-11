const hre = require("hardhat");

async function main() {
  console.log("🏛️ [QSDG-CLOUD] Memulai prosesi peluncuran Koin Utama QSTATE...");
  
  // Menjalankan kompilasi ulang otomatis untuk merajut bumbu resep EVM Target Paris
  await hre.run("compile");

  const TokenFactory = await hre.ethers.getContractFactory("QSTATE");
  console.log("🚀 Menembakkan kontrak raksasa (Genesis 1T, Max Supply 200T) ke satelit Chainstack...");
  
  const token = await TokenFactory.deploy();
  await token.deployed();

  console.log("===============================================================");
  console.log("✅ KOIN UTAMA $QSTATE SUKSES AKTIF ON-CHAIN GEGAP GEMPITA!");
  console.log("📍 QSTATE CONTRACT ADDRESS FINAL:", token.address);
  console.log("===============================================================");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Peluncuran Gagal:", error);
    process.exit(1);
  });
