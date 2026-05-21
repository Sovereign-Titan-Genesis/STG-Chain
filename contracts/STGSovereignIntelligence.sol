// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Intelligence Contract
/// @notice Integrasi intelijen strategis, analisis ancaman, dan early-warning system on-chain
contract STGSovereignIntelligence {
    address public governance;
    address public auditor;

    struct ThreatReport {
        uint256 id;
        string source;        // contoh: "Cyber", "Border", "Economic"
        string description;   // deskripsi ancaman
        uint256 severity;     // tingkat ancaman (0-100)
        uint256 timestamp;
        bool verified;
    }

    struct EarlyWarning {
        uint256 id;
        string signal;        // contoh: "DDoS spike", "Border breach", "Financial anomaly"
        string action;        // rekomendasi tindakan: "alert_defense", "activate_protocol"
        uint256 confidence;   // tingkat keyakinan (0-100)
        uint256 timestamp;
        bool executed;
    }

    mapping(uint256 => ThreatReport) public threats;
    mapping(uint256 => EarlyWarning) public warnings;
    uint256 public threatCount;
    uint256 public warningCount;

    event ThreatReported(uint256 id, string source, uint256 severity, uint256 timestamp);
    event ThreatVerified(uint256 id, address auditor);
    event WarningIssued(uint256 id, string signal, string action, uint256 confidence, uint256 timestamp);
    event WarningExecuted(uint256 id, string action);

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

    /// @notice Laporkan ancaman strategis
    function reportThreat(string memory _source, string memory _description, uint256 _severity) external onlyGovernance {
        threatCount++;
        threats[threatCount] = ThreatReport({
            id: threatCount,
            source: _source,
            description: _description,
            severity: _severity,
            timestamp: block.timestamp,
            verified: false
        });
        emit ThreatReported(threatCount, _source, _severity, block.timestamp);
    }

    /// @notice Verifikasi ancaman oleh auditor eksternal
    function verifyThreat(uint256 _id) external onlyAuditor {
        require(_id <= threatCount, "Threat tidak ada");
        threats[_id].verified = true;
        emit ThreatVerified(_id, msg.sender);
    }

    /// @notice Keluarkan sinyal peringatan dini
    function issueWarning(string memory _signal, string memory _action, uint256 _confidence) external onlyGovernance {
        warningCount++;
        warnings[warningCount] = EarlyWarning({
            id: warningCount,
            signal: _signal,
            action: _action,
            confidence: _confidence,
            timestamp: block.timestamp,
            executed: false
        });
        emit WarningIssued(warningCount, _signal, _action, _confidence, block.timestamp);
    }

    /// @notice Eksekusi protokol peringatan dini
    function executeWarning(uint256 _id) external onlyGovernance {
        require(_id <= warningCount, "Warning tidak ada");
        warnings[_id].executed = true;
        emit WarningExecuted(_id, warnings[_id].action);
    }
}
