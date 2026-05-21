// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Media Contract
/// @notice Integrasi kebebasan pers, distribusi informasi, dan sensor digital berdaulat
contract STGSovereignMedia {
    address public governance;
    address public auditor;

    struct Publication {
        uint256 id;
        address publisher;
        string title;          // judul berita/artikel
        string contentHash;    // hash/IPFS dari konten
        string status;         // contoh: "submitted", "approved", "restricted"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Publication) public publications;
    uint256 public publicationCount;

    event PublicationSubmitted(uint256 id, address publisher, string title, uint256 timestamp);
    event PublicationApproved(uint256 id, string title);
    event PublicationRestricted(uint256 id, string title);
    event PublicationVerified(uint256 id, address auditor);

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

    /// @notice Ajukan publikasi media baru
    function submitPublication(string memory _title, string memory _contentHash) external {
        publicationCount++;
        publications[publicationCount] = Publication({
            id: publicationCount,
            publisher: msg.sender,
            title: _title,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit PublicationSubmitted(publicationCount, msg.sender, _title, block.timestamp);
    }

    /// @notice Setujui publikasi media
    function approvePublication(uint256 _id) external onlyGovernance {
        require(_id <= publicationCount, "Publication tidak ada");
        publications[_id].status = "approved";
        emit PublicationApproved(_id, publications[_id].title);
    }

    /// @notice Restriksi publikasi media (sensor berdaulat)
    function restrictPublication(uint256 _id) external onlyGovernance {
        require(_id <= publicationCount, "Publication tidak ada");
        publications[_id].status = "restricted";
        emit PublicationRestricted(_id, publications[_id].title);
    }

    /// @notice Verifikasi publikasi oleh auditor eksternal
    function verifyPublication(uint256 _id) external onlyAuditor {
        require(_id <= publicationCount, "Publication tidak ada");
        publications[_id].verified = true;
        emit PublicationVerified(_id, msg.sender);
    }
}
