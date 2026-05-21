// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Quantum Security Layer Contract
/// @notice Integrasi enkripsi kuantum, post-quantum cryptography, dan zero-knowledge proof
contract STGQuantumSecurityLayer {
    address public governance;
    address public auditor;

    struct QuantumKey {
        uint256 id;
        bytes32 publicKeyHash;   // hash dari public key post-quantum
        uint256 timestamp;
        bool active;
    }

    struct ZKProof {
        uint256 id;
        bytes proofData;         // data proof (zk-SNARK/zk-STARK)
        string context;          // contoh: "transaction", "validator_auth"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => QuantumKey) public quantumKeys;
    mapping(uint256 => ZKProof) public zkProofs;
    uint256 public keyCount;
    uint256 public proofCount;

    event QuantumKeyRegistered(uint256 id, bytes32 publicKeyHash, uint256 timestamp);
    event ZKProofSubmitted(uint256 id, string context, uint256 timestamp);
    event ZKProofVerified(uint256 id, address auditor);

    modifier onlyGovernance() {
        require(msg.sender == governance, "Hanya governance");
        _;
    }

    modifier onlyAuditor() {
        require(msg.sender == auditor, "Hanya auditor");
        _;
    }

    constructor(address _governance, address _auditor) {
        governance = _governance;
        auditor = _auditor;
    }

    /// @notice Registrasi kunci post-quantum
    function registerQuantumKey(bytes32 _publicKeyHash) external onlyGovernance {
        keyCount++;
        quantumKeys[keyCount] = QuantumKey({
            id: keyCount,
            publicKeyHash: _publicKeyHash,
            timestamp: block.timestamp,
            active: true
        });
        emit QuantumKeyRegistered(keyCount, _publicKeyHash, block.timestamp);
    }

    /// @notice Submit zero-knowledge proof
    function submitZKProof(bytes memory _proofData, string memory _context) external onlyGovernance {
        proofCount++;
        zkProofs[proofCount] = ZKProof({
            id: proofCount,
            proofData: _proofData,
            context: _context,
            timestamp: block.timestamp,
            verified: false
        });
        emit ZKProofSubmitted(proofCount, _context, block.timestamp);
    }

    /// @notice Verifikasi proof oleh auditor eksternal
    function verifyZKProof(uint256 _id) external onlyAuditor {
        require(_id <= proofCount, "Proof tidak ada");
        zkProofs[_id].verified = true;
        emit ZKProofVerified(_id, msg.sender);
    }
}
