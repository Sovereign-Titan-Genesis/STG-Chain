// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Data & Knowledge Contract
/// @notice Integrasi perpustakaan digital, manajemen data, dan akses pengetahuan on-chain
contract STGSovereignDataKnowledge {
    address public governance;
    address public auditor;

    struct ImmutableLibrary {
        uint256 id;
        string title;          // contoh: "Arsip Abadi Nusantara"
        string contentHash;    // hash/IPFS dokumen
        string category;       // "history", "curriculum", "technology"
        string status;         // "archived", "active"
        uint256 timestamp;
        bool verified;
    }

    struct AccessProtocol {
        uint256 id;
        string gateway;        // contoh: "Sovereign Access Node"
        string description;
        string status;         // "enabled", "disabled"
        uint256 timestamp;
        bool verified;
    }

    struct DataVault {
        uint256 id;
        string title;          // contoh: "Master File 653MB"
        string encryption;     // "AES-256", "Quantum-Resistant"
        string status;         // "locked", "unlocked"
        uint256 timestamp;
        bool verified;
    }

    struct KnowledgeContribution {
        uint256 id;
        address contributor;
        string moduleTitle;    // contoh: "Quantum Literacy 101"
        string rewardStatus;   // "pending", "rewarded"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => ImmutableLibrary) public libraries;
    mapping(uint256 => AccessProtocol) public protocols;
    mapping(uint256 => DataVault) public vaults;
    mapping(uint256 => KnowledgeContribution) public contributions;

    uint256 public libraryCount;
    uint256 public protocolCount;
    uint256 public vaultCount;
    uint256 public contributionCount;

    event LibraryArchived(uint256 id, string title, string category, uint256 timestamp);
    event ProtocolEnabled(uint256 id, string gateway, uint256 timestamp);
    event VaultLocked(uint256 id, string title, string encryption, uint256 timestamp);
    event ContributionSubmitted(uint256 id, address contributor, string moduleTitle, uint256 timestamp);
    event ContributionRewarded(uint256 id, address contributor, string moduleTitle);
    event Verified(uint256 id, string category, address auditor);

    modifier onlyGovernance() {
        require(msg.sender == governance, "Hanya governance pusat");
        _;
    }

    modifier onlyAuditor() {
        require(msg.sender == auditor, "Hanya auditor eksternal");
        _;
    }

    constructor(address _governance, address _auditor) {
        governance = _governance;
        auditor = _auditor;
    }

    /// @notice Arsipkan dokumen ke Immutable Library
    function archiveLibrary(string memory _title, string memory _contentHash, string memory _category) external onlyGovernance {
        libraryCount++;
        libraries[libraryCount] = ImmutableLibrary({
            id: libraryCount,
            title: _title,
            contentHash: _contentHash,
            category: _category,
            status: "archived",
            timestamp: block.timestamp,
            verified: false
        });
        emit LibraryArchived(libraryCount, _title, _category, block.timestamp);
    }

    /// @notice Aktifkan Sovereign Access Protocol
    function enableProtocol(string memory _gateway, string memory _description) external onlyGovernance {
        protocolCount++;
        protocols[protocolCount] = AccessProtocol({
            id: protocolCount,
            gateway: _gateway,
            description: _description,
            status: "enabled",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProtocolEnabled(protocolCount, _gateway, block.timestamp);
    }

    /// @notice Kunci Data Security Vault
    function lockVault(string memory _title, string memory _encryption) external onlyGovernance {
        vaultCount++;
        vaults[vaultCount] = DataVault({
            id: vaultCount,
            title: _title,
            encryption: _encryption,
            status: "locked",
            timestamp: block.timestamp,
            verified: false
        });
        emit VaultLocked(vaultCount, _title, _encryption, block.timestamp);
    }

    /// @notice Ajukan kontribusi pengetahuan
    function submitContribution(address _contributor, string memory _moduleTitle) external onlyGovernance {
        contributionCount++;
        contributions[contributionCount] = KnowledgeContribution({
            id: contributionCount,
            contributor: _contributor,
            moduleTitle: _moduleTitle,
            rewardStatus: "pending",
            timestamp: block.timestamp,
            verified: false
        });
        emit ContributionSubmitted(contributionCount, _contributor, _moduleTitle, block.timestamp);
    }

    /// @notice Berikan penghargaan atas kontribusi pengetahuan
    function rewardContribution(uint256 _id) external onlyGovernance {
        require(_id <= contributionCount, "Contribution tidak ada");
        contributions[_id].rewardStatus = "rewarded";
        emit ContributionRewarded(_id, contributions[_id].contributor, contributions[_id].moduleTitle);
    }

    /// @notice Verifikasi library/protocol/vault/contribution oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("library"))) {
            require(_id <= libraryCount, "Library tidak ada");
            libraries[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("protocol"))) {
            require(_id <= protocolCount, "Protocol tidak ada");
            protocols[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("vault"))) {
            require(_id <= vaultCount, "Vault tidak ada");
            vaults[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("contribution"))) {
            require(_id <= contributionCount, "Contribution tidak ada");
            contributions[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
