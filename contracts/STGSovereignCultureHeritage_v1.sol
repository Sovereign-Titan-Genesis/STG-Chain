// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Culture & Heritage Contract
/// @notice Integrasi pelestarian budaya, arsip warisan, dan ekspresi seni on-chain
contract STGSovereignCultureHeritage {
    address public governance;
    address public auditor;

    struct CulturalAsset {
        uint256 id;
        string name;           // contoh: "Batik Mega Mendung"
        string category;       // "artifact", "tradition", "artwork"
        string status;         // "registered", "protected", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct HeritageArchive {
        uint256 id;
        string title;          // contoh: "Oral History of Sundanese"
        string contentHash;    // hash/IPFS arsip digital
        string status;         // "submitted", "approved", "restricted"
        uint256 timestamp;
        bool verified;
    }

    struct ArtisticExpression {
        uint256 id;
        address creator;
        string workTitle;      // contoh: "Digital Wayang Kulit"
        string medium;         // "music", "dance", "visual"
        string status;         // "exhibited", "archived"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => CulturalAsset) public assets;
    mapping(uint256 => HeritageArchive) public archives;
    mapping(uint256 => ArtisticExpression) public expressions;

    uint256 public assetCount;
    uint256 public archiveCount;
    uint256 public expressionCount;

    event AssetRegistered(uint256 id, string name, string category, uint256 timestamp);
    event AssetVerified(uint256 id, address auditor);
    event ArchiveSubmitted(uint256 id, string title, uint256 timestamp);
    event ArchiveApproved(uint256 id, string title);
    event ExpressionCreated(uint256 id, address creator, string workTitle, string medium, uint256 timestamp);
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

    /// @notice Registrasi aset budaya
    function registerAsset(string memory _name, string memory _category) external onlyGovernance {
        assetCount++;
        assets[assetCount] = CulturalAsset({
            id: assetCount,
            name: _name,
            category: _category,
            status: "registered",
            timestamp: block.timestamp,
            verified: false
        });
        emit AssetRegistered(assetCount, _name, _category, block.timestamp);
    }

    /// @notice Verifikasi aset budaya
    function verifyAsset(uint256 _id) external onlyAuditor {
        require(_id <= assetCount, "Asset tidak ada");
        assets[_id].verified = true;
        emit AssetVerified(_id, msg.sender);
    }

    /// @notice Ajukan arsip warisan budaya
    function submitArchive(string memory _title, string memory _contentHash) external {
        archiveCount++;
        archives[archiveCount] = HeritageArchive({
            id: archiveCount,
            title: _title,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit ArchiveSubmitted(archiveCount, _title, block.timestamp);
    }

    /// @notice Setujui arsip warisan budaya
    function approveArchive(uint256 _id) external onlyGovernance {
        require(_id <= archiveCount, "Archive tidak ada");
        archives[_id].status = "approved";
        emit ArchiveApproved(_id, archives[_id].title);
    }

    /// @notice Buat ekspresi seni digital
    function createExpression(address _creator, string memory _workTitle, string memory _medium) external onlyGovernance {
        expressionCount++;
        expressions[expressionCount] = ArtisticExpression({
            id: expressionCount,
            creator: _creator,
            workTitle: _workTitle,
            medium: _medium,
            status: "exhibited",
            timestamp: block.timestamp,
            verified: false
        });
        emit ExpressionCreated(expressionCount, _creator, _workTitle, _medium, block.timestamp);
    }

    /// @notice Verifikasi arsip/ekspresi oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("asset"))) {
            require(_id <= assetCount, "Asset tidak ada");
            assets[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("archive"))) {
            require(_id <= archiveCount, "Archive tidak ada");
            archives[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("expression"))) {
            require(_id <= expressionCount, "Expression tidak ada");
            expressions[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
