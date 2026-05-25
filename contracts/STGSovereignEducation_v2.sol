// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Education & Certification Contract
/// @notice Mengelola kurikulum berdaulat, ujian mandiri, sertifikasi warga, dan homeschooling kits on-chain
contract STGSovereignEducation {
    address public governance;
    address public educationSentinel;

    struct Curriculum {
        uint256 id;
        string name;           // contoh: "Literasi Kuantum & AI Dasar"
        string metadataIPFS;   // modul, video, dan buku teks di IPFS
        uint256 totalModules;
        bool isActive;
    }

    struct CitizenProgress {
        uint256 completedModules;
        uint256 examScore;
        bool isCertified;
        uint256 certificationTimestamp;
    }

    struct HomeschoolingKit {
        uint256 kitId;
        string targetAgeGroup;
        string ipfsPackageHash;
        bool distributed;
    }

    mapping(uint256 => Curriculum) public curriculums;
    mapping(address => mapping(uint256 => CitizenProgress)) public citizenTracks;
    mapping(uint256 => HomeschoolingKit) public familyKits;
    mapping(address => bool) public registeredFamilies;

    uint256 public curriculumCount;
    uint256 public kitCount;

    event CurriculumPublished(uint256 indexed id, string name, uint256 totalModules);
    event ExamPassed(address indexed citizen, uint256 indexed curriculumId, uint256 score);
    event CertificateIssued(address indexed citizen, uint256 indexed curriculumId, uint256 timestamp);
    event FamilyKitRegistered(uint256 indexed kitId, string targetAgeGroup);
    event KitDispatched(uint256 indexed kitId, address indexed family);

    modifier onlyGovernance() {
        require(msg.sender == governance, "Hanya untuk Komando Pusat Governance");
        _;
    }

    modifier onlyEducationSentinel() {
        require(msg.sender == educationSentinel, "Hanya untuk Auditor Pendidikan");
        _;
    }

    constructor(address _governance, address _educationSentinel) {
        governance = _governance;
        educationSentinel = _educationSentinel;
    }

    /// @notice Publikasikan kurikulum baru (Quantum Literacy, ESG, Digital Identity)
    function publishCurriculum(string memory _name, string memory _metadataIPFS, uint256 _totalModules) external onlyGovernance {
        curriculumCount++;
        curriculums[curriculumCount] = Curriculum({
            id: curriculumCount,
            name: _name,
            metadataIPFS: _metadataIPFS,
            totalModules: _totalModules,
            isActive: true
        });
        emit CurriculumPublished(curriculumCount, _name, _totalModules);
    }

    /// @notice Daftarkan keluarga mandiri (Homeschooling) ke jaringan STG
    function registerHomeschoolingFamily(address _family) external onlyGovernance {
        registeredFamilies[_family] = true;
    }

    /// @notice Rilis Kit Pembelajaran Keluarga Baru
    function createLearningKit(string memory _ageGroup, string memory _ipfsHash) external onlyGovernance {
        kitCount++;
        familyKits[kitCount] = HomeschoolingKit({
            kitId: kitCount,
            targetAgeGroup: _ageGroup,
            ipfsPackageHash: _ipfsHash,
            distributed: false
        });
        emit FamilyKitRegistered(kitCount, _ageGroup);
    }

    /// @notice Kirim/Klaim Kit Belajar secara otomatis via Posko Berdaulat
    function claimFamilyKit(uint256 _kitId) external {
        require(registeredFamilies[msg.sender], "Hanya untuk keluarga homeschooling terdaftar");
        require(!familyKits[_kitId].distributed, "Kit sudah didistribusikan");
        
        familyKits[_kitId].distributed = true;
        emit KitDispatched(_kitId, msg.sender);
    }

    /// @notice Catat kelulusan ujian warga secara objektif (Diproses otomatis oleh AI)
    function submitExamResult(address _citizen, uint256 _curriculumId, uint256 _score, uint256 _modulesDone) external onlyEducationSentinel {
        require(curriculums[_curriculumId].isActive, "Kurikulum tidak aktif");
        require(_score >= 75, "Skor di bawah batas kelulusan STG (75)");

        CitizenProgress storage progress = citizenTracks[_citizen][_curriculumId];
        progress.completedModules = _modulesDone;
        progress.examScore = _score;
        progress.isCertified = true;
        progress.certificationTimestamp = block.timestamp;

        emit ExamPassed(_citizen, _curriculumId, _score);
        emit CertificateIssued(_citizen, _curriculumId, block.timestamp);
    }
}
