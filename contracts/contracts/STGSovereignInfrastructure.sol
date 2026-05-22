// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Infrastructure Contract
/// @notice Integrasi pembangunan digital, transportasi, dan utilitas publik on-chain
contract STGSovereignInfrastructure {
    address public governance;
    address public auditor;

    struct Project {
        uint256 id;
        string name;           // contoh: "Digital Highway", "Smart Grid"
        string category;       // "digital", "transportation", "utilities"
        uint256 budget;        // dana dalam token STG
        string status;         // "initiated", "in_progress", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct UtilityService {
        uint256 id;
        string serviceName;    // contoh: "Water Supply", "Electric Grid"
        string status;         // "operational", "maintenance", "outage"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Project) public projects;
    mapping(uint256 => UtilityService) public services;

    uint256 public projectCount;
    uint256 public serviceCount;

    event ProjectInitiated(uint256 id, string name, string category, uint256 budget, uint256 timestamp);
    event ProjectCompleted(uint256 id, string name);
    event ServiceRegistered(uint256 id, string serviceName, string status, uint256 timestamp);
    event ServiceUpdated(uint256 id, string serviceName, string status);
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

    /// @notice Inisiasi proyek infrastruktur baru
    function initiateProject(string memory _name, string memory _category, uint256 _budget) external onlyGovernance {
        projectCount++;
        projects[projectCount] = Project({
            id: projectCount,
            name: _name,
            category: _category,
            budget: _budget,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProjectInitiated(projectCount, _name, _category, _budget, block.timestamp);
    }

    /// @notice Tandai proyek selesai
    function completeProject(uint256 _id) external onlyGovernance {
        require(_id <= projectCount, "Project tidak ada");
        projects[_id].status = "completed";
        emit ProjectCompleted(_id, projects[_id].name);
    }

    /// @notice Registrasi layanan utilitas publik
    function registerService(string memory _serviceName, string memory _status) external onlyGovernance {
        serviceCount++;
        services[serviceCount] = UtilityService({
            id: serviceCount,
            serviceName: _serviceName,
            status: _status,
            timestamp: block.timestamp,
            verified: false
        });
        emit ServiceRegistered(serviceCount, _serviceName, _status, block.timestamp);
    }

    /// @notice Update status layanan utilitas publik
    function updateService(uint256 _id, string memory _status) external onlyGovernance {
        require(_id <= serviceCount, "Service tidak ada");
        services[_id].status = _status;
        services[_id].timestamp = block.timestamp;
        emit ServiceUpdated(_id, services[_id].serviceName, _status);
    }

    /// @notice Verifikasi proyek/layanan oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("project"))) {
            require(_id <= projectCount, "Project tidak ada");
            projects[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("service"))) {
            require(_id <= serviceCount, "Service tidak ada");
            services[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
