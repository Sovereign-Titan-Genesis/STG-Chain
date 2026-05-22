// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Innovation Contract
/// @notice Integrasi ide kreatif, inkubasi teknologi, dan ekosistem startup on-chain
contract STGSovereignInnovation {
    address public governance;
    address public auditor;

    struct Idea {
        uint256 id;
        address innovator;
        string title;          // judul ide kreatif
        string description;    // deskripsi ide
        string status;         // "submitted", "approved", "incubated"
        uint256 timestamp;
        bool verified;
    }

    struct Incubator {
        uint256 id;
        string name;           // nama inkubator
        string focus;          // fokus: "AI", "Biotech", "Web3"
        uint256 budget;        // dana dalam token STG
        string status;         // "active", "suspended"
        uint256 timestamp;
        bool verified;
    }

    struct Startup {
        uint256 id;
        address founder;
        string projectName;    // nama startup
        string sector;         // sektor: "Fintech", "HealthTech", "EduTech"
        uint256 funding;       // dana dalam token STG
        string status;         // "seed", "seriesA", "seriesB", "exit"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Idea) public ideas;
    mapping(uint256 => Incubator) public incubators;
    mapping(uint256 => Startup) public startups;

    uint256 public ideaCount;
    uint256 public incubatorCount;
    uint256 public startupCount;

    event IdeaSubmitted(uint256 id, address innovator, string title, uint256 timestamp);
    event IdeaApproved(uint256 id, string title);
    event IncubatorCreated(uint256 id, string name, uint256 budget, uint256 timestamp);
    event StartupFounded(uint256 id, address founder, string projectName, uint256 funding, uint256 timestamp);
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

    /// @notice Ajukan ide kreatif baru
    function submitIdea(string memory _title, string memory _description) external {
        ideaCount++;
        ideas[ideaCount] = Idea({
            id: ideaCount,
            innovator: msg.sender,
            title: _title,
            description: _description,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit IdeaSubmitted(ideaCount, msg.sender, _title, block.timestamp);
    }

    /// @notice Setujui ide kreatif
    function approveIdea(uint256 _id) external onlyGovernance {
        require(_id <= ideaCount, "Idea tidak ada");
        ideas[_id].status = "approved";
        emit IdeaApproved(_id, ideas[_id].title);
    }

    /// @notice Buat inkubator teknologi baru
    function createIncubator(string memory _name, string memory _focus, uint256 _budget) external onlyGovernance {
        incubatorCount++;
        incubators[incubatorCount] = Incubator({
            id: incubatorCount,
            name: _name,
            focus: _focus,
            budget: _budget,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit IncubatorCreated(incubatorCount, _name, _budget, block.timestamp);
    }

    /// @notice Dirikan startup baru
    function foundStartup(address _founder, string memory _projectName, string memory _sector, uint256 _funding) external onlyGovernance {
        startupCount++;
        startups[startupCount] = Startup({
            id: startupCount,
            founder: _founder,
            projectName: _projectName,
            sector: _sector,
            funding: _funding,
            status: "seed",
            timestamp: block.timestamp,
            verified: false
        });
        emit StartupFounded(startupCount, _founder, _projectName, _funding, block.timestamp);
    }

    /// @notice Verifikasi ide/inkubator/startup oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("idea"))) {
            require(_id <= ideaCount, "Idea tidak ada");
            ideas[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("incubator"))) {
            require(_id <= incubatorCount, "Incubator tidak ada");
            incubators[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("startup"))) {
            require(_id <= startupCount, "Startup tidak ada");
            startups[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
