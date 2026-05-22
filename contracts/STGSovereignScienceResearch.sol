// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Science & Research Contract
/// @notice Integrasi riset ilmiah, publikasi digital, dan kolaborasi penelitian on-chain
contract STGSovereignScienceResearch {
    address public governance;
    address public auditor;

    struct ResearchProject {
        uint256 id;
        string title;          // contoh: "Quantum Computing Study"
        string field;          // contoh: "Physics", "Biotech", "AI"
        string status;         // "proposed", "active", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct Publication {
        uint256 id;
        string title;          // judul publikasi
        string contentHash;    // hash/IPFS publikasi digital
        string status;         // "submitted", "approved", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct Collaboration {
        uint256 id;
        address partner;
        string projectTitle;   // judul proyek kolaborasi
        string status;         // "initiated", "ongoing", "finished"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => ResearchProject) public projects;
    mapping(uint256 => Publication) public publications;
    mapping(uint256 => Collaboration) public collaborations;

    uint256 public projectCount;
    uint256 public publicationCount;
    uint256 public collaborationCount;

    event ProjectProposed(uint256 id, string title, string field, uint256 timestamp);
    event ProjectCompleted(uint256 id, string title);
    event PublicationSubmitted(uint256 id, string title, uint256 timestamp);
    event PublicationApproved(uint256 id, string title);
    event CollaborationInitiated(uint256 id, address partner, string projectTitle, uint256 timestamp);
    event CollaborationFinished(uint256 id, string projectTitle);
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

    /// @notice Ajukan proyek riset ilmiah
    function proposeProject(string memory _title, string memory _field) external onlyGovernance {
        projectCount++;
        projects[projectCount] = ResearchProject({
            id: projectCount,
            title: _title,
            field: _field,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProjectProposed(projectCount, _title, _field, block.timestamp);
    }

    /// @notice Tandai proyek riset selesai
    function completeProject(uint256 _id) external onlyGovernance {
        require(_id <= projectCount, "Project tidak ada");
        projects[_id].status = "completed";
        emit ProjectCompleted(_id, projects[_id].title);
    }

    /// @notice Ajukan publikasi digital
    function submitPublication(string memory _title, string memory _contentHash) external {
        publicationCount++;
        publications[publicationCount] = Publication({
            id: publicationCount,
            title: _title,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit PublicationSubmitted(publicationCount, _title, block.timestamp);
    }

    /// @notice Setujui publikasi digital
    function approvePublication(uint256 _id) external onlyGovernance {
        require(_id <= publicationCount, "Publication tidak ada");
        publications[_id].status = "approved";
        emit PublicationApproved(_id, publications[_id].title);
    }

    /// @notice Inisiasi kolaborasi penelitian
    function initiateCollaboration(address _partner, string memory _projectTitle) external onlyGovernance {
        collaborationCount++;
        collaborations[collaborationCount] = Collaboration({
            id: collaborationCount,
            partner: _partner,
            projectTitle: _projectTitle,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit CollaborationInitiated(collaborationCount, _partner, _projectTitle, block.timestamp);
    }

    /// @notice Tandai kolaborasi selesai
    function finishCollaboration(uint256 _id) external onlyGovernance {
        require(_id <= collaborationCount, "Collaboration tidak ada");
        collaborations[_id].status = "finished";
        emit CollaborationFinished(_id, collaborations[_id].projectTitle);
    }

    /// @notice Verifikasi proyek/publikasi/kolaborasi oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("project"))) {
            require(_id <= projectCount, "Project tidak ada");
            projects[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("publication"))) {
            require(_id <= publicationCount, "Publication tidak ada");
            publications[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("collaboration"))) {
            require(_id <= collaborationCount, "Collaboration tidak ada");
            collaborations[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
