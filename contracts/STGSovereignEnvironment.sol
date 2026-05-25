// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Environment Contract
/// @notice Integrasi perlindungan lingkungan, pengelolaan sumber daya, dan sistem ekologi berdaulat
contract STGSovereignEnvironment {
    address public governance;
    address public auditor;

    struct EnvironmentalProgram {
        uint256 id;
        string title;          // contoh: "Forest Conservation Initiative"
        string description;
        string status;         // "active", "suspended", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct ResourceManagement {
        uint256 id;
        string resource;       // contoh: "Water", "Energy", "Waste"
        string policy;         // contoh: "Water Recycling Policy"
        string status;         // "implemented", "reviewed", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct EcologicalReport {
        uint256 id;
        string subject;        // contoh: "Carbon Emission Analysis"
        string contentHash;    // hash/IPFS laporan ekologi
        string status;         // "submitted", "validated", "archived"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => EnvironmentalProgram) public programs;
    mapping(uint256 => ResourceManagement) public resources;
    mapping(uint256 => EcologicalReport) public reports;

    uint256 public programCount;
    uint256 public resourceCount;
    uint256 public reportCount;

    event ProgramCreated(uint256 id, string title, uint256 timestamp);
    event ProgramSuspended(uint256 id, string title);
    event ResourcePolicyAdded(uint256 id, string resource, string policy, uint256 timestamp);
    event ResourcePolicyUpdated(uint256 id, string resource, string status);
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

    /// @notice Buat program perlindungan lingkungan
    function createProgram(string memory _title, string memory _description) external onlyGovernance {
        programCount++;
        programs[programCount] = EnvironmentalProgram({
            id: programCount,
            title: _title,
            description: _description,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProgramCreated(programCount, _title, block.timestamp);
    }

    /// @notice Suspend program lingkungan
    function suspendProgram(uint256 _id) external onlyGovernance {
        require(_id <= programCount, "Program tidak ada");
        programs[_id].status = "suspended";
        emit ProgramSuspended(_id, programs[_id].title);
    }

    /// @notice Tambahkan kebijakan pengelolaan sumber daya
    function addResourcePolicy(string memory _resource, string memory _policy) external onlyGovernance {
        resourceCount++;
        resources[resourceCount] = ResourceManagement({
            id: resourceCount,
            resource: _resource,
            policy: _policy,
            status: "implemented",
            timestamp: block.timestamp,
            verified: false
        });
        emit ResourcePolicyAdded(resourceCount, _resource, _policy, block.timestamp);
    }

    /// @notice Update status kebijakan sumber daya
    function updateResourcePolicy(uint256 _id, string memory _status) external onlyGovernance {
        require(_id <= resourceCount, "Resource policy tidak ada");
        resources[_id].status = _status;
        emit ResourcePolicyUpdated(_id, resources[_id].resource, _status);
    }

    /// @notice Ajukan laporan ekologi
    function submitReport(string memory _subject, string memory _contentHash) external {
        reportCount++;
        reports[reportCount] = EcologicalReport({
            id: reportCount,
            subject: _subject,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit ReportSubmitted(reportCount, _subject, block.timestamp);
    }

    /// @notice Validasi laporan ekologi
    function validateReport(uint256 _id) external onlyGovernance {
        require(_id <= reportCount, "Report tidak ada");
        reports[_id].status = "validated";
        emit ReportValidated(_id, reports[_id].subject);
    }

    /// @notice Verifikasi program/resource/report oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("program"))) {
            require(_id <= programCount, "Program tidak ada");
            programs[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("resource"))) {
            require(_id <= resourceCount, "Resource policy tidak ada");
            resources[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("report"))) {
            require(_id <= reportCount, "Report tidak ada");
            reports[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
