// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Culture & Heritage Contract
/// @notice Integrasi pelestarian budaya, arsip warisan, dan ekspresi seni on-chain
contract STGSovereignCultureHeritage {
    address public governance;
    address public auditor;

    struct HeritageArchive {
        uint256 id;
        string title;          // contoh: "Manuskrip Batik Kuno"
        string contentHash;    // IPFS hash arsip budaya
        string category;       // "manuscript", "artifact", "oral-tradition"
        string status;         // "archived", "active"
        uint256 timestamp;
        bool verified;
    }

    struct CulturalProgram {
        uint256 id;
        string name;           // contoh: "Festival Wayang On-Chain"
        string description;
        string status;         // "planned", "active", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct ArtisticExpression {
        uint256 id;
        address creator;
        string artworkTitle;   // contoh: "NFT Tari Saman"
        string contentHash;    // IPFS hash karya seni
        string status;         // "submitted", "validated", "archived"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => HeritageArchive) public archives;
    mapping(uint256 => CulturalProgram) public programs;
    mapping(uint256 => ArtisticExpression) public artworks;

    uint256 public archiveCount;
    uint256 public programCount;
    uint256 public artworkCount;

    event ArchiveCreated(uint256 id, string title, string category, uint256 timestamp);
    event ProgramLaunched(uint256 id, string name, uint256 timestamp);
    event ArtworkSubmitted(uint256 id, address creator, string artworkTitle, uint256 timestamp);
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

    /// @notice Buat arsip warisan budaya
    function createArchive(string memory _title, string memory _contentHash, string memory _category) external onlyGovernance {
        archiveCount++;
        archives[archiveCount] = HeritageArchive({
            id: archiveCount,
            title: _title,
            contentHash: _contentHash,
            category: _category,
            status: "archived",
            timestamp: block.timestamp,
            verified: false
        });
        emit ArchiveCreated(archiveCount, _title, _category, block.timestamp);
    }

    /// @notice Luncurkan program budaya
    function launchProgram(string memory _name, string memory _description) external onlyGovernance {
        programCount++;
        programs[programCount] = CulturalProgram({
            id: programCount,
            name: _name,
            description: _description,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProgramLaunched(programCount, _name, block.timestamp);
    }

    /// @notice Ajukan karya seni on-chain
    function submitArtwork(address _creator, string memory _artworkTitle, string memory _contentHash) external onlyGovernance {
        artworkCount++;
        artworks[artworkCount] = ArtisticExpression({
            id: artworkCount,
            creator: _creator,
            artworkTitle: _artworkTitle,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit ArtworkSubmitted(artworkCount, _creator, _artworkTitle, block.timestamp);
    }

    /// @notice Verifikasi arsip/program/karya seni oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("archive"))) {
            require(_id <= archiveCount, "Archive tidak ada");
            archives[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("program"))) {
            require(_id <= programCount, "Program tidak ada");
            programs[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("artwork"))) {
            require(_id <= artworkCount, "Artwork tidak ada");
            artworks[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
