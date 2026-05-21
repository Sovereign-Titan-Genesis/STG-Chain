// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Identity Contract
/// @notice Integrasi DID, biometrik, dan liveness detection ke dalam identitas digital STG
contract STGSovereignIdentity {
    address public governance;
    address public auditor;

    struct Identity {
        uint256 id;
        address owner;
        string did;             // Decentralized Identifier (DID)
        bytes32 biometricHash;  // hash biometrik (iris/fingerprint)
        uint256 livenessScore;  // skor liveness detection (0-100)
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Identity) public identities;
    uint256 public identityCount;

    event IdentityRegistered(uint256 id, address owner, string did, uint256 timestamp);
    event IdentityVerified(uint256 id, address auditor);
    event IdentityUpdated(uint256 id, uint256 livenessScore, bytes32 biometricHash);

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

    /// @notice Registrasi identitas berdaulat baru
    function registerIdentity(address _owner, string memory _did, bytes32 _biometricHash, uint256 _livenessScore) external onlyGovernance {
        identityCount++;
        identities[identityCount] = Identity({
            id: identityCount,
            owner: _owner,
            did: _did,
            biometricHash: _biometricHash,
            livenessScore: _livenessScore,
            timestamp: block.timestamp,
            verified: false
        });
        emit IdentityRegistered(identityCount, _owner, _did, block.timestamp);
    }

    /// @notice Update biometrik dan liveness detection
    function updateIdentity(uint256 _id, bytes32 _biometricHash, uint256 _livenessScore) external onlyGovernance {
        require(_id <= identityCount, "Identity tidak ada");
        identities[_id].biometricHash = _biometricHash;
        identities[_id].livenessScore = _livenessScore;
        identities[_id].timestamp = block.timestamp;
        emit IdentityUpdated(_id, _livenessScore, _biometricHash);
    }

    /// @notice Verifikasi identitas oleh auditor eksternal
    function verifyIdentity(uint256 _id) external onlyAuditor {
        require(_id <= identityCount, "Identity tidak ada");
        identities[_id].verified = true;
        emit IdentityVerified(_id, msg.sender);
    }
}
