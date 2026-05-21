// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Cultural Contract
/// @notice Integrasi warisan budaya, seni digital, dan identitas kolektif on-chain
contract STGSovereignCultural {
    address public governance;
    address public auditor;

    struct Heritage {
        uint256 id;
        string name;           // contoh: "Batik Parang", "Wayang Kulit"
        string description;    // deskripsi warisan budaya
        string status;         // "registered", "protected", "revived"
        uint256 timestamp;
        bool verified;
    }

    struct ArtPiece {
        uint256 id;
        address creator;
        string title;          // judul karya seni digital
        string contentHash;    // hash/IPFS karya seni
        string status;         // "submitted", "approved", "exhibited"
        uint256 timestamp;
        bool verified;
    }

    struct Identity {
        uint256 id;
        address citizen;
        string symbol;         // simbol identitas kolektif (contoh: motif, logo, avatar)
        string meaning;        // makna simbol
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Heritage) public heritages;
    mapping(uint256 => ArtPiece) public artPieces;
    mapping(uint256 => Identity) public identities;

    uint256 public heritageCount;
    uint256 public artCount;
    uint256 public identityCount;

    event HeritageRegistered(uint256 id, string name, uint256 timestamp);
    event HeritageVerified(uint256 id, address auditor);
    event ArtSubmitted(uint256 id, address creator, string title, uint256 timestamp);
    event ArtApproved(uint256 id, string title);
    event IdentityCreated(uint256 id, address citizen, string symbol, uint256 timestamp);
    event IdentityVerified(uint256 id, address auditor);

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

    /// @notice Registrasi warisan budaya
    function registerHeritage(string memory _name, string memory _description) external onlyGovernance {
        heritageCount++;
        heritages[heritageCount] = Heritage({
            id: heritageCount,
            name: _name,
            description: _description,
            status: "registered",
            timestamp: block.timestamp,
            verified: false
        });
        emit HeritageRegistered(heritageCount, _name, block.timestamp);
    }

    /// @notice Verifikasi warisan budaya oleh auditor eksternal
    function verifyHeritage(uint256 _id) external onlyAuditor {
        require(_id <= heritageCount, "Heritage tidak ada");
        heritages[_id].verified = true;
        emit HeritageVerified(_id, msg.sender);
    }

    /// @notice Ajukan karya seni digital
    function submitArt(string memory _title, string memory _contentHash) external {
        artCount++;
        artPieces[artCount] = ArtPiece({
            id: artCount,
            creator: msg.sender,
            title: _title,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit ArtSubmitted(artCount, msg.sender, _title, block.timestamp);
    }

    /// @notice Setujui karya seni digital
    function approveArt(uint256 _id) external onlyGovernance {
        require(_id <= artCount, "Art tidak ada");
        artPieces[_id].status = "approved";
        emit ArtApproved(_id, artPieces[_id].title);
    }

    /// @notice Buat identitas kolektif warga STG
    function createIdentity(address _citizen, string memory _symbol, string memory _meaning) external onlyGovernance {
        identityCount++;
        identities[identityCount] = Identity({
            id: identityCount,
            citizen: _citizen,
            symbol: _symbol,
            meaning: _meaning,
            timestamp: block.timestamp,
            verified: false
        });
        emit IdentityCreated(identityCount, _citizen, _symbol, block.timestamp);
    }

    /// @notice Verifikasi identitas kolektif oleh auditor eksternal
    function verifyIdentity(uint256 _id) external onlyAuditor {
        require(_id <= identityCount, "Identity tidak ada");
        identities[_id].verified = true;
        emit IdentityVerified(_id, msg.sender);
    }
}
