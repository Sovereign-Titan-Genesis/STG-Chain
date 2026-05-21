// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Science & Technology Contract
/// @notice Integrasi riset, inovasi, dan pengembangan teknologi on-chain
contract STGSovereignScienceTech {
    address public governance;
    address public auditor;

    struct Research {
        uint256 id;
        string title;          // judul riset
        string field;          // bidang: "AI", "Biotech", "Blockchain"
        string description;    // deskripsi riset
        string status;         // "proposed", "in_progress", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct Innovation {
        uint256 id;
        string projectName;    // nama proyek inovasi
        string impact;         // dampak: "increase_efficiency", "new_protocol"
        uint256 funding;       // dana dalam token STG
        string status;         // "initiated", "developing", "deployed"
        uint256 timestamp;
        bool verified;
    }

    struct Patent {
        uint256 id;
        address inventor;
        string title;          // judul paten
        string patentHash;     // hash/IPFS dokumen paten
        uint256 timestamp;
        bool approved;
    }

    mapping(uint256 => Research) public researches;
    mapping(uint256 => Innovation) public innovations;
    mapping(uint256 => Patent) public patents;

    uint256 public researchCount;
    uint256 public innovationCount;
    uint256 public patentCount;

    event ResearchProposed(uint256 id, string title, string field, uint256 timestamp);
    event ResearchVerified(uint256 id, address auditor);
    event InnovationInitiated(uint256 id, string projectName, uint256 funding, uint256 timestamp);
    event InnovationDeployed(uint256 id, string projectName);
    event PatentFiled(uint256 id, address inventor, string title, uint256 timestamp);
    event PatentApproved(uint256 id, string title);

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

    /// @notice Ajukan riset baru
    function proposeResearch(string memory _title, string memory _field, string memory _description) external onlyGovernance {
        researchCount++;
        researches[researchCount] = Research({
            id: researchCount,
            title: _title,
            field: _field,
            description: _description,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit ResearchProposed(researchCount, _title, _field, block.timestamp);
    }

    /// @notice Verifikasi riset oleh auditor eksternal
    function verifyResearch(uint256 _id) external onlyAuditor {
        require(_id <= researchCount, "Research tidak ada");
        researches[_id].verified = true;
        emit ResearchVerified(_id, msg.sender);
    }

    /// @notice Inisiasi proyek inovasi
    function initiateInnovation(string memory _projectName, string memory _impact, uint256 _funding) external onlyGovernance {
        innovationCount++;
        innovations[innovationCount] = Innovation({
            id: innovationCount,
            projectName: _projectName,
            impact: _impact,
            funding: _funding,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit InnovationInitiated(innovationCount, _projectName, _funding, block.timestamp);
    }

    /// @notice Tandai inovasi sebagai deployed
    function deployInnovation(uint256 _id) external onlyGovernance {
        require(_id <= innovationCount, "Innovation tidak ada");
        innovations[_id].status = "deployed";
        emit InnovationDeployed(_id, innovations[_id].projectName);
    }

    /// @notice Ajukan paten baru
    function filePatent(string memory _title, string memory _patentHash) external {
        patentCount++;
        patents[patentCount] = Patent({
            id: patentCount,
            inventor: msg.sender,
            title: _title,
            patentHash: _patentHash,
            timestamp: block.timestamp,
            approved: false
        });
        emit PatentFiled(patentCount, msg.sender, _title, block.timestamp);
    }

    /// @notice Setujui paten oleh governance
    function approvePatent(uint256 _id) external onlyGovernance {
        require(_id <= patentCount, "Patent tidak ada");
        patents[_id].approved = true;
        emit PatentApproved(_id, patents[_id].title);
    }
}
