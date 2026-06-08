/**
 * @title QSDG - IBW Global Showcase Execution Script
 * @notice Memicu simulasi transaksi masal antar-wilayah Nusantara untuk pameran kedaulatan di IBW
 * @author Pandawa 5 AI under command of Sultan Andi Muhammad Harpianto (2026)
 */

const REGIONAL_NODES = [
    { name: "🧰 CORE BENGKEL (LAB)", wallet: "0xD9a1E28224d6d047Eef8712dC97d11A9032b948e" },
    { name: "⚡ BINTARO JAKARTA", wallet: "0x70997970C51812dc3A010C7d01b50e0d17dc79C8" },
    { name: "📦 CIRACAS HUB", wallet: "0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC" },
    { name: "🏛️ YOGYAKARTA PREFECTURE", wallet: "0x90F79bf6EB2c4f870365E785982E1f101E93b906" },
    { name: "🚢 MEDAN GATEWAY", wallet: "0x15d34AAf54267DB7D7c367839AAf71A00a2C6A65" },
    { name: "🌳 PEKANBARU NODE", wallet: "0x9965507D1a05BC2a2631b8e74d66e8688a47697c" },
    { name: "⚓ MAKASSAR PORT", wallet: "0x23618e81E3f5cdF7f54C3d65f7FBc0aBf5B21E8f" }
];

async function startIBWShowcaseTx() {
    const logBox = document.querySelector(".log-box");
    const ticker = document.getElementById("ticker");
    
    if (!logBox) return;

    ticker.innerText = "🚨 [IBW MODE] ACTIVATING NUSANTARA CROSS-BORDER LOGISTICS PROPAGATION... 🚨";
    ticker.style.color = "#ffcc00";

    for (let i = 0; i < REGIONAL_NODES.length; i++) {
        setTimeout(() => {
            const source = REGIONAL_NODES[i];
            const destination = REGIONAL_NODES[(i + 1) % REGIONAL_NODES.length];
            // Nominal mikro AKSA menggunakan rujukan nilai 14.890
            const txAmount = (Math.random() * 5000 + 14890).toFixed(4); 
            
            // Generate Baris Log Visual untuk Tampilan Layar Monitor Sultan
            const newLog = document.createElement("div");
            newLog.style.color = "#00ff99";
            newLog.innerHTML = `[TRANSACTION] ${source.name} ──► Sent ${txAmount} AKSA ──► ${destination.name} [⚡ LATENCY: 0.0003s]`;
            
            logBox.appendChild(newLog);
            
            // Auto scroll log agar monitor bergerak canggih di depan audiens IBW
            logBox.scrollTop = logBox.scrollHeight;
            
            // Picu getaran sensor penyimpanan database harian
            if (typeof triggerStorageIOActivity === "function") {
                triggerStorageIOActivity();
            }
        }, i * 1500); // Jeda pengiriman antar kota 1.5 detik
    }
}
