// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Governance Dashboard Contract
/// @notice Integrasi voting, treasury, ESG, dan dokumentasi ke satu antarmuka live dashboard
contract STGGovernanceDashboard {
    address public governance;
    address public auditor;

    struct DashboardEntry {
        uint256 id;
        string module;       // contoh: "Voting", "Treasury", "ESG", "Docs"
        string reference;    // hash/ID dari kontrak terkait
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => DashboardEntry) public entries;
    uint256 public entryCount;

    event DashboardEntryAdded(uint256 id, string module, string reference, uint256 timestamp);
    event DashboardEntryVerified(uint256 id, address auditor);

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

    /// @notice Tambahkan modul baru ke dashboard (Voting, Treasury, ESG, Docs)
    function addEntry(string memory _module, string memory _reference) external onlyGovernance {
        entryCount++;
        entries[entryCount] = DashboardEntry({
            id: entryCount,
            module: _module,
            reference: _reference,
            timestamp: block.timestamp,
            verified: false
        });
        emit DashboardEntryAdded(entryCount, _module, _reference, block.timestamp);
    }

    /// @notice Verifikasi modul dashboard oleh auditor eksternal
    function verifyEntry(uint256 _id) external onlyAuditor {
        require(_id <= entryCount, "Entry tidak ada");
        entries[_id].verified = true;
        emit DashboardEntryVerified(_id, msg.sender);
    }
}


