// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Executive Contract
/// @notice Integrasi eksekusi kebijakan, implementasi undang-undang, dan koordinasi lintas kementerian digital
contract STGSovereignExecutive {
    address public governance;
    address public auditor;

    struct Policy {
        uint256 id;
        string title;          // judul kebijakan
        string lawReference;   // referensi undang-undang terkait
        string ministry;       // kementerian digital yang bertanggung jawab
        string status;         // contoh: "initiated", "in_progress", "executed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Policy) public policies;
    uint256 public policyCount;

    event PolicyInitiated(uint256 id, string title, string ministry, uint256 timestamp);
    event PolicyExecuted(uint256 id, string title, string ministry);
    event PolicyVerified(uint256 id, address auditor);

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

    /// @notice Inisiasi kebijakan baru
    function initiatePolicy(string memory _title, string memory _lawReference, string memory _ministry) external onlyGovernance {
        policyCount++;
        policies[policyCount] = Policy({
            id: policyCount,
            title: _title,
            lawReference: _lawReference,
            ministry: _ministry,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit PolicyInitiated(policyCount, _title, _ministry, block.timestamp);
    }

    /// @notice Eksekusi kebijakan oleh kementerian digital
    function executePolicy(uint256 _id) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].status = "executed";
        emit PolicyExecuted(_id, policies[_id].title, policies[_id].ministry);
    }

    /// @notice Verifikasi kebijakan oleh auditor eksternal
    function verifyPolicy(uint256 _id) external onlyAuditor {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].verified = true;
        emit PolicyVerified(_id, msg.sender);
    }
}
