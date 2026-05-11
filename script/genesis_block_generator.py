# GENESIS BLOCK GENERATOR v1.0
# To be executed on STG-Chain Devnet → Mainnet
# Condition: First Guardian Verified

import hashlib
import datetime
import json

# Eternal Sigil Message
GENESIS_MESSAGE = "Nusantara-Root: One Heart, One Key. 100K Quadrillion Sovereignty Sealed by the Giant's Breath. VIVA AUTHENTIC."

# Identity of Sultan (Founder)
FOUNDER_NAME = "Andi Muhammad Harpianto"
FOUNDER_ROLE = "CFO/CTO & Co-Founder, Sovereign Titan Genesis"
GUARDIAN_ID = "PENDING_VERIFICATION"  # Replace with First Guardian wallet

def generate_genesis_block():
    timestamp = datetime.datetime.utcnow().strftime("%Y-%m-%d %H:%M:%S UTC")
    genesis_data = {
        "block_number": 0,
        "timestamp": timestamp,
        "founder": FOUNDER_NAME,
        "role": FOUNDER_ROLE,
        "guardian": GUARDIAN_ID,
        "message": GENESIS_MESSAGE
    }

    # Generate Genesis Hash
    genesis_string = json.dumps(genesis_data, sort_keys=True)
    genesis_hash = hashlib.sha256(genesis_string.encode()).hexdigest()
    genesis_data["hash"] = genesis_hash

    print("=" * 70)
    print("🚀 INITIALIZING STG-CHAIN GENESIS BLOCK...")
    print(f"📡 MESSAGE: {GENESIS_MESSAGE}")
    print(f"👑 FOUNDER: {FOUNDER_NAME}")
    print(f"🔐 GENESIS HASH: {genesis_hash}")
    print(f"🏛️ STATUS: SOVEREIGNTY SEALED & IMMUTABLE")
    print("=" * 70)

    # Save to genesis.json
    with open("../database/genesis_block.json", "w") as f:
        json.dump(genesis_data, f, indent=4)

if __name__ == "__main__":
    generate_genesis_block()
  
