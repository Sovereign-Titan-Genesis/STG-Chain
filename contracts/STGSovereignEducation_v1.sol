// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Education Contract
/// @notice Integrasi kurikulum digital, sertifikasi warga, dan sistem pembelajaran on-chain
contract STGSovereignEducation {
    address public governance;
    address public auditor;

    struct Curriculum {
        uint256 id;
        string title;          // contoh: "Digital Citizenship"
        string description;
        string status;         // "active", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct Certification {
        uint256 id;
        address citizen;
        string certificateTitle; // contoh: "Blockchain Literacy Certificate"
        string status;           // "issued", "revoked"
        uint256 timestamp;
        bool verified;
    }

    struct LearningModule {
        uint256 id;
        string moduleName;     // contoh: "Smart Contract Basics"
        string contentHash;    // hash/IPFS materi pembelajaran
        string status;         // "published", "updated", "archived"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Curriculum) public curricula;
    mapping(uint256 => Certification) public certifications;
    mapping(uint256 => LearningModule) public modules;

    uint256 public curriculumCount;
    uint256 public certificationCount;
    uint256 public moduleCount;

    event CurriculumCreated(uint256 id, string title, uint256 timestamp);
    event CurriculumArchived(uint256 id, string title);
    event CertificationIssued(uint256 id, address citizen, string certificateTitle, uint256 timestamp);
    event CertificationRevoked(uint256 id, address citizen);
    event ModulePublished(uint256 id, string moduleName, uint256 timestamp);
    event ModuleUpdated(uint256 id, string moduleName);
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

    /// @notice Buat kurikulum digital baru
    function createCurriculum(string memory _title, string memory _description) external onlyGovernance {
        curriculumCount++;
        curricula[curriculumCount] = Curriculum({
            id: curriculumCount,
            title: _title,
            description: _description,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit CurriculumCreated(curriculumCount, _title, block.timestamp);
    }

    /// @notice Arsipkan kurikulum
    function archiveCurriculum(uint256 _id) external onlyGovernance {
        require(_id <= curriculumCount, "Curriculum tidak ada");
        curricula[_id].status = "archived";
        emit CurriculumArchived(_id, curricula[_id].title);
    }

    /// @notice Terbitkan sertifikat warga
    function issueCertification(address _citizen, string memory _certificateTitle) external onlyGovernance {
        certificationCount++;
        certifications[certificationCount] = Certification({
            id: certificationCount,
            citizen: _citizen,
            certificateTitle: _certificateTitle,
            status: "issued",
            timestamp: block.timestamp,
            verified: false
        });
        emit CertificationIssued(certificationCount, _citizen, _certificateTitle, block.timestamp);
    }

    /// @notice Cabut sertifikat warga
    function revokeCertification(uint256 _id) external onlyGovernance {
        require(_id <= certificationCount, "Certification tidak ada");
        certifications[_id].status = "revoked";
        emit CertificationRevoked(_id, certifications[_id].citizen);
    }

    /// @notice Publikasikan modul pembelajaran
    function publishModule(string memory _moduleName, string memory _contentHash) external onlyGovernance {
        moduleCount++;
        modules[moduleCount] = LearningModule({
            id: moduleCount,
            moduleName: _moduleName,
            contentHash: _contentHash,
            status: "published",
            timestamp: block.timestamp,
            verified: false
        });
        emit ModulePublished(moduleCount, _moduleName, block.timestamp);
    }

    /// @notice Update modul pembelajaran
    function updateModule(uint256 _id, string memory _contentHash) external onlyGovernance {
        require(_id <= moduleCount, "Module tidak ada");
        modules[_id].contentHash = _contentHash;
        modules[_id].status = "updated";
        emit ModuleUpdated(_id, modules[_id].moduleName);
    }

    /// @notice Verifikasi kurikulum/sertifikasi/modul oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("curriculum"))) {
            require(_id <= curriculumCount, "Curriculum tidak ada");
            curricula[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("certification"))) {
            require(_id <= certificationCount, "Certification tidak ada");
            certifications[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("module"))) {
            require(_id <= moduleCount, "Module tidak ada");
            modules[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
