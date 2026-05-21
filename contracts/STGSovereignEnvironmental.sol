// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Environmental Contract
/// @notice Integrasi kebijakan lingkungan, energi hijau, dan keberlanjutan on-chain
contract STGSovereignEnvironmental {
    address public governance;
    address public auditor;

    struct GreenPolicy {
        uint256 id;
        string title;          // contoh: "Carbon Neutrality", "Renewable Energy Expansion"
        string description;    // detail kebijakan
        string status;         // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    struct SustainabilityProject {
        uint256 id;
        string projectName;    // contoh: "Solar Farm STG", "Reforestation Program"
        string impact;         // dampak: "reduce_emission", "increase_green_energy"
        uint256 budget;        // dana dalam token STG
        string status;         // "initiated", "in_progress", "completed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => GreenPolicy) public policies;
    mapping(uint256 => SustainabilityProject) public projects;
    uint256 public policyCount;
    uint256 public projectCount;

    event PolicyProposed(uint256 id, string title, uint256 timestamp);
    event PolicyExecuted(uint256 id, string title);
    event ProjectInitiated(uint256 id, string projectName, uint256 budget, uint256 timestamp);
    event ProjectCompleted(uint256 id, string projectName);
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

    /// @notice Ajukan kebijakan lingkungan baru
    function proposePolicy(string memory _title, string memory _description) external onlyGovernance {
        policyCount++;
        policies[policyCount] = GreenPolicy({
            id: policyCount,
            title: _title,
            description: _description,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit PolicyProposed(policyCount, _title, block.timestamp);
    }

    /// @notice Eksekusi kebijakan lingkungan
    function executePolicy(uint256 _id) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].status = "executed";
        emit PolicyExecuted(_id, policies[_id].title);
    }

    /// @notice Inisiasi proyek keberlanjutan
    function initiateProject(string memory _projectName, string memory _impact, uint256 _budget) external onlyGovernance {
        projectCount++;
        projects[projectCount] = SustainabilityProject({
            id: projectCount,
            projectName: _projectName,
            impact: _impact,
            budget: _budget,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProjectInitiated(projectCount, _projectName, _budget, block.timestamp);
    }

    /// @notice Tandai proyek keberlanjutan selesai
    function completeProject(uint256 _id) external onlyGovernance {
        require(_id <= projectCount, "Project tidak ada");
        projects[_id].status = "completed";
        emit ProjectCompleted(_id, projects[_id].projectName);
    }

    /// @notice Verifikasi kebijakan/proyek oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("policy"))) {
            require(_id <= policyCount, "Policy tidak ada");
            policies[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("project"))) {
            require(_id <= projectCount, "Project tidak ada");
            projects[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
