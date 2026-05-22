// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Infrastructure Contract
/// @notice Integrasi pembangunan digital, manajemen aset publik, dan sistem infrastruktur berdaulat
contract STGSovereignInfrastructure {
    address public governance;
    address public auditor;

    struct InfrastructureProject {
        uint256 id;
        string title;          // contoh: "Smart City Grid"
        string description;
        string status;         // "planned", "active", "completed"
        uint256 budget;
        uint256 timestamp;
        bool verified;
    }

    struct PublicAsset {
        uint256 id;
        string name;           // contoh: "Digital Bridge"
        string category;       // "transport", "energy", "communication"
        string status;         // "operational", "maintenance", "decommissioned"
        uint256 timestamp;
        bool verified;
    }

    struct InfrastructurePolicy {
        uint256 id;
        string title;          // contoh: "Green Energy Mandate"
        string description;
        string status;         // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => InfrastructureProject) public projects;
    mapping(uint256 => PublicAsset) public assets;
    mapping(uint256 => InfrastructurePolicy) public policies;

    uint256 public projectCount;
    uint256 public assetCount;
    uint256 public policyCount;

    event ProjectPlanned(uint256 id, string title, uint256 budget, uint256 timestamp);
    event ProjectCompleted(uint256 id, string title);
    event AssetRegistered(uint256 id, string name, string category, uint256 timestamp);
    event AssetUpdated(uint256 id, string name, string status);
    event PolicyProposed(uint256 id, string title, uint256 timestamp);
    event PolicyExecuted(uint256 id, string title);
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

    /// @notice Rencanakan proyek infrastruktur digital
    function planProject(string memory _title, string memory _description, uint256 _budget) external onlyGovernance {
        projectCount++;
        projects[projectCount] = InfrastructureProject({
            id: projectCount,
            title: _title,
            description: _description,
            status: "planned",
            budget: _budget,
            timestamp: block.timestamp,
            verified: false
        });
        emit ProjectPlanned(projectCount, _title, _budget, block.timestamp);
    }

    /// @notice Tandai proyek selesai
    function completeProject(uint256 _id) external onlyGovernance {
        require(_id <= projectCount, "Project tidak ada");
        projects[_id].status = "completed";
        emit ProjectCompleted(_id, projects[_id].title);
    }

    /// @notice Registrasi aset publik
    function registerAsset(string memory _name, string memory _category) external onlyGovernance {
        assetCount++;
        assets[assetCount] = PublicAsset({
            id: assetCount,
            name: _name,
            category: _category,
            status: "operational",
            timestamp: block.timestamp,
            verified: false
        });
        emit AssetRegistered(assetCount, _name, _category, block.timestamp);
    }

    /// @notice Update status aset publik
    function updateAsset(uint256 _id, string memory _status) external onlyGovernance {
        require(_id <= assetCount, "Asset tidak ada");
        assets[_id].status = _status;
        emit AssetUpdated(_id, assets[_id].name, _status);
    }

    /// @notice Ajukan kebijakan infrastruktur
    function proposePolicy(string memory _title, string memory _description) external onlyGovernance {
        policyCount++;
        policies[policyCount] = InfrastructurePolicy({
            id: policyCount,
            title: _title,
            description: _description,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit PolicyProposed(policyCount, _title, block.timestamp);
    }

    /// @notice Eksekusi kebijakan infrastruktur
    function executePolicy(uint256 _id) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].status = "executed";
        emit PolicyExecuted(_id, policies[_id].title);
    }

    /// @notice Verifikasi proyek/aset/kebijakan oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("project"))) {
            require(_id <= projectCount, "Project tidak ada");
            projects[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("asset"))) {
            require(_id <= assetCount, "Asset tidak ada");
            assets[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("policy"))) {
            require(_id <= policyCount, "Policy tidak ada");
            policies[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
