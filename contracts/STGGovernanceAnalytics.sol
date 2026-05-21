// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Governance Analytics Contract
/// @notice Integrasi voting, treasury, ESG, dokumentasi, dan validator ke dalam analitik prediktif
contract STGGovernanceAnalytics {
    address public governance;
    address public auditor;

    struct AnalyticsEntry {
        uint256 id;
        string module;       // contoh: "Voting", "Treasury", "ESG", "Docs", "Validator"
        string metric;       // contoh: "ProposalSuccessRate", "CarbonFootprint", "Uptime"
        uint256 value;       // nilai metrik
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => AnalyticsEntry) public analytics;
    uint256 public analyticsCount;

    event AnalyticsSubmitted(uint256 id, string module, string metric, uint256 value, uint256 timestamp);
    event AnalyticsVerified(uint256 id, address auditor);

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

    /// @notice Submit data analitik dari modul governance
    function submitAnalytics(string memory _module, string memory _metric, uint256 _value) external onlyGovernance {
        analyticsCount++;
        analytics[analyticsCount] = AnalyticsEntry({
            id: analyticsCount,
            module: _module,
            metric: _metric,
            value: _value,
            timestamp: block.timestamp,
            verified: false
        });
        emit AnalyticsSubmitted(analyticsCount, _module, _metric, _value, block.timestamp);
    }

    /// @notice Verifikasi data analitik oleh auditor eksternal
    function verifyAnalytics(uint256 _id) external onlyAuditor {
        require(_id <= analyticsCount, "Analytics tidak ada");
        analytics[_id].verified = true;
        emit AnalyticsVerified(_id, msg.sender);
    }
}
