// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Diplomatic Contract
/// @notice Integrasi hubungan luar negeri, perjanjian internasional, dan protokol diplomasi digital
contract STGSovereignDiplomatic {
    address public governance;
    address public auditor;

    struct Treaty {
        uint256 id;
        string partner;       // contoh: "ASEAN", "EU", "UN DAO", "African Union"
        string agreement;     // isi perjanjian (hash/IPFS)
        string status;        // contoh: "proposed", "signed", "ratified"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Treaty) public treaties;
    uint256 public treatyCount;

    event TreatyProposed(uint256 id, string partner, string agreement, uint256 timestamp);
    event TreatySigned(uint256 id, string partner);
    event TreatyRatified(uint256 id, string partner);
    event TreatyVerified(uint256 id, address auditor);

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

    /// @notice Ajukan perjanjian diplomatik baru
    function proposeTreaty(string memory _partner, string memory _agreement) external onlyGovernance {
        treatyCount++;
        treaties[treatyCount] = Treaty({
            id: treatyCount,
            partner: _partner,
            agreement: _agreement,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit TreatyProposed(treatyCount, _partner, _agreement, block.timestamp);
    }

    /// @notice Tandatangani perjanjian diplomatik
    function signTreaty(uint256 _id) external onlyGovernance {
        require(_id <= treatyCount, "Treaty tidak ada");
        treaties[_id].status = "signed";
        emit TreatySigned(_id, treaties[_id].partner);
    }

    /// @notice Ratifikasi perjanjian diplomatik
    function ratifyTreaty(uint256 _id) external onlyGovernance {
        require(_id <= treatyCount, "Treaty tidak ada");
        treaties[_id].status = "ratified";
        emit TreatyRatified(_id, treaties[_id].partner);
    }

    /// @notice Verifikasi perjanjian oleh auditor eksternal
    function verifyTreaty(uint256 _id) external onlyAuditor {
        require(_id <= treatyCount, "Treaty tidak ada");
        treaties[_id].verified = true;
        emit TreatyVerified(_id, msg.sender);
    }
}
