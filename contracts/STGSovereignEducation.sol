// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Education Contract
/// @notice Integrasi kurikulum digital, akses pendidikan, dan sertifikasi on-chain
contract STGSovereignEducation {
    address public governance;
    address public auditor;

    struct Course {
        uint256 id;
        string title;          // judul kursus
        string curriculumHash; // hash/IPFS kurikulum digital
        string status;         // contoh: "open", "closed", "completed"
        uint256 timestamp;
        bool verified;
    }

    struct Certificate {
        uint256 id;
        address student;
        string courseTitle;
        string certHash;       // hash/IPFS sertifikat digital
        uint256 timestamp;
        bool valid;
    }

    mapping(uint256 => Course) public courses;
    mapping(uint256 => Certificate) public certificates;
    uint256 public courseCount;
    uint256 public certificateCount;

    event CourseCreated(uint256 id, string title, uint256 timestamp);
    event CourseVerified(uint256 id, address auditor);
    event CertificateIssued(uint256 id, address student, string courseTitle, uint256 timestamp);
    event CertificateRevoked(uint256 id, address governance);

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

    /// @notice Buat kursus baru dengan kurikulum digital
    function createCourse(string memory _title, string memory _curriculumHash) external onlyGovernance {
        courseCount++;
        courses[courseCount] = Course({
            id: courseCount,
            title: _title,
            curriculumHash: _curriculumHash,
            status: "open",
            timestamp: block.timestamp,
            verified: false
        });
        emit CourseCreated(courseCount, _title, block.timestamp);
    }

    /// @notice Verifikasi kursus oleh auditor eksternal
    function verifyCourse(uint256 _id) external onlyAuditor {
        require(_id <= courseCount, "Course tidak ada");
        courses[_id].verified = true;
        emit CourseVerified(_id, msg.sender);
    }

    /// @notice Terbitkan sertifikat digital untuk siswa
    function issueCertificate(address _student, string memory _courseTitle, string memory _certHash) external onlyGovernance {
        certificateCount++;
        certificates[certificateCount] = Certificate({
            id: certificateCount,
            student: _student,
            courseTitle: _courseTitle,
            certHash: _certHash,
            timestamp: block.timestamp,
            valid: true
        });
        emit CertificateIssued(certificateCount, _student, _courseTitle, block.timestamp);
    }

    /// @notice Cabut sertifikat digital
    function revokeCertificate(uint256 _id) external onlyGovernance {
        require(_id <= certificateCount, "Certificate tidak ada");
        certificates[_id].valid = false;
        emit CertificateRevoked(_id, msg.sender);
    }
}
