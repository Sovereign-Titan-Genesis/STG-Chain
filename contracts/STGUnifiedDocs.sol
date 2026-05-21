// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Unified Documentation Portal Contract
/// @notice Sinkronisasi changelog, SOP, dan laporan lintas tim ke docs.quorumstate.international
contract STGUnifiedDocs {
    address public governance;
    address public auditor;

    struct DocEntry {
        uint256 id;
        string category;     // contoh: "SOP", "Changelog", "Audit Report"
        string contentHash;  // IPFS/Arweave hash untuk konten
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => DocEntry) public docs;
    uint256 public docCount;

    event DocSubmitted(uint256 id, string category, string contentHash, uint256 timestamp);
    event DocVerified(uint256 id, address auditor);

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

    /// @notice Submit dokumen baru (SOP, changelog, laporan)
    function submitDoc(string memory _category, string memory _contentHash) external onlyGovernance {
        docCount++;
        docs[docCount] = DocEntry({
            id: docCount,
            category: _category,
            contentHash: _contentHash,
            timestamp: block.timestamp,
            verified: false
        });
        emit DocSubmitted(docCount, _category, _contentHash, block.timestamp);
    }

    /// @notice Verifikasi dokumen oleh auditor eksternal
    function verifyDoc(uint256 _id) external onlyAuditor {
        require(_id <= docCount, "Dokumen tidak ada");
        docs[_id].verified = true;
        emit DocVerified(_id, msg.sender);
    }
}



