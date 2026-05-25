// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Security Contract
/// @notice Integrasi keamanan publik, perlindungan warga, dan sistem intelijen on-chain
contract STGSovereignSecurity {
    address public governance;
    address public auditor;

    struct PublicSafety {
        uint256 id;
        string title;          // contoh: "Neighborhood Watch"
        string description;
        string status;         // "active", "suspended"
        uint256 timestamp;
        bool verified;
    }

    struct CitizenProtection {
        uint256 id;
        address citizen;
        string protectionType; // contoh: "Identity Shield", "Emergency Alert"
        string status;         // "granted", "revoked"
        uint256 timestamp;
        bool verified;
    }

    struct IntelligenceReport {
        uint256 id;
        string subject;        // contoh: "Cyber Threat Analysis"
        string contentHash;    // hash/IPFS laporan intelijen
        string status;         // "submitted", "validated", "archived"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => PublicSafety) public safeties;
    mapping(uint256 => CitizenProtection) public protections;
    mapping(uint256 => IntelligenceReport) public reports;

    uint256 public safetyCount;
    uint256 public protectionCount;
    uint256 public reportCount;

    event SafetyCreated(uint256 id, string title, uint256 timestamp);
    event SafetySuspended(uint256 id, string title);
    event ProtectionGranted(uint256 id, address citizen, string protectionType, uint256 timestamp);
    event ProtectionRevoked(uint256 id, address citizen);
    event ReportSubmitted(uint256 id, string subject, uint256 timestamp);
    event ReportValidated(uint256 id, string subject);
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

    /// @notice Buat program keamanan publik
    function createSafety(string memory _title, string memory _description) external onlyGovernance {
        safetyCount++;
        safeties[safetyCount] = PublicSafety({
            id: safetyCount,
            title: _title,
            description: _description,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit SafetyCreated(safetyCount, _title, block.timestamp);
    }

    /// @notice Suspend program keamanan publik
    function suspendSafety(uint256 _id) external onlyGovernance {
        require(_id <= safetyCount, "Safety tidak ada");
        safeties[_id].status = "suspended";
        emit SafetySuspended(_id, safeties[_id].title);
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

    /// @notice Ajukan laporan intelijen
    function submitReport(string memory _subject, string memory _contentHash) external {
        reportCount++;
        reports[reportCount] = IntelligenceReport({
            id: reportCount,
            subject: _subject,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit ReportSubmitted(reportCount, _subject, block.timestamp);
    }

    /// @notice Validasi laporan intelijen
    function validateReport(uint256 _id) external onlyGovernance {
        require(_id <= reportCount, "Report tidak ada");
        reports[_id].status = "validated";
        emit ReportValidated(_id, reports[_id].subject);
    }

    /// @notice Verifikasi safety/protection/report oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("safety"))) {
            require(_id <= safetyCount, "Safety tidak ada");
            safeties[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("protection"))) {
            require(_id <= protectionCount, "Protection tidak ada");
            protections[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("report"))) {
            require(_id <= reportCount, "Report tidak ada");
            reports[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
