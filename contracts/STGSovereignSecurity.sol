// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Security Contract
/// @notice Integrasi keamanan publik, perlindungan warga, dan sistem darurat on-chain
contract STGSovereignSecurity {
    address public governance;
    address public auditor;

    struct PublicSafety {
        uint256 id;
        string initiative;     // contoh: "Neighborhood Watch", "Cyber Patrol"
        string status;         // "initiated", "active", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct CitizenProtection {
        uint256 id;
        address citizen;
        string protectionType; // contoh: "Witness Protection", "Emergency Shelter"
        string status;         // "granted", "revoked"
        uint256 timestamp;
        bool verified;
    }

    struct EmergencyAlert {
        uint256 id;
        string alertType;      // contoh: "Natural Disaster", "Civil Unrest"
        string action;         // contoh: "evacuation", "lockdown"
        uint256 timestamp;
        bool executed;
    }

    mapping(uint256 => PublicSafety) public safeties;
    mapping(uint256 => CitizenProtection) public protections;
    mapping(uint256 => EmergencyAlert) public alerts;

    uint256 public safetyCount;
    uint256 public protectionCount;
    uint256 public alertCount;

    event SafetyInitiated(uint256 id, string initiative, uint256 timestamp);
    event SafetyVerified(uint256 id, address auditor);
    event ProtectionGranted(uint256 id, address citizen, string protectionType, uint256 timestamp);
    event ProtectionRevoked(uint256 id, address citizen);
    event AlertIssued(uint256 id, string alertType, string action, uint256 timestamp);
    event AlertExecuted(uint256 id, string action);

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

    /// @notice Inisiasi program keamanan publik
    function initiateSafety(string memory _initiative) external onlyGovernance {
        safetyCount++;
        safeties[safetyCount] = PublicSafety({
            id: safetyCount,
            initiative: _initiative,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit SafetyInitiated(safetyCount, _initiative, block.timestamp);
    }

    /// @notice Verifikasi program keamanan publik
    function verifySafety(uint256 _id) external onlyAuditor {
        require(_id <= safetyCount, "Safety tidak ada");
        safeties[_id].verified = true;
        emit SafetyVerified(_id, msg.sender);
    }

    /// @notice Berikan perlindungan warga
    function grantProtection(address _citizen, string memory _protectionType) external onlyGovernance {
        protectionCount++;
        protections[protectionCount] = CitizenProtection({
            id: protectionCount,
            citizen: _citizen,
            protectionType: _protectionType,
            status: "granted",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProtectionGranted(protectionCount, _citizen, _protectionType, block.timestamp);
    }

    /// @notice Cabut perlindungan warga
    function revokeProtection(uint256 _id) external onlyGovernance {
        require(_id <= protectionCount, "Protection tidak ada");
        protections[_id].status = "revoked";
        emit ProtectionRevoked(_id, protections[_id].citizen);
    }

    /// @notice Keluarkan peringatan darurat
    function issueAlert(string memory _alertType, string memory _action) external onlyGovernance {
        alertCount++;
        alerts[alertCount] = EmergencyAlert({
            id: alertCount,
            alertType: _alertType,
            action: _action,
            timestamp: block.timestamp,
            executed: false
        });
        emit AlertIssued(alertCount, _alertType, _action, block.timestamp);
    }

    /// @notice Eksekusi protokol darurat
    function executeAlert(uint256 _id) external onlyGovernance {
        require(_id <= alertCount, "Alert tidak ada");
        alerts[_id].executed = true;
        emit AlertExecuted(_id, alerts[_id].action);
    }
}
