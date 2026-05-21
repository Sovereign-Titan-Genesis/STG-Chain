// Simulasi Pemantauan Aktivitas LevelDB Storage di Dashboard UI
export function triggerStorageIOActivity() {
    const ioStatus = document.getElementById('storage-io-status');
    const densityBar = document.getElementById('storage-density-bar');
    const bytesCounter = document.getElementById('disk-bytes-counter');

    if (ioStatus) {
        // Mengubah status visual menjadi berkedip memproses data (Disk Write)
        ioStatus.innerText = "💾 WRITING STATE TO DISK...";
        ioStatus.style.color = "#ffcc00";
        
        setTimeout(() => {
            ioStatus.innerText = "⚡ STANDBY (SYNCHRONIZED)";
            ioStatus.style.color = "#00ff00";
            
            // Mensimulasikan pertumbuhan ukuran database kecil secara dinamis
            const currentBytes = (parseFloat(bytesCounter.innerText.replace(/[^0-9.]/g, '')) + 0.12).toFixed(2);
            bytesCounter.innerText = `Allocated Index: ${currentBytes} KB`;
            densityBar.style.width = `${Math.min(parseInt(densityBar.style.width) + 1, 100)}%`;
        }, 800);
    }
}

// Hubungkan triggerStorageIOActivity() ini di dalam fungsi transfer sukses Anda 
// agar setiap kali saldo bermutasi, visual LevelDB ikut merespons penulisan disk.
