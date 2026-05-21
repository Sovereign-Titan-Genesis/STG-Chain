// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Labor & Welfare Contract
/// @notice Integrasi hak pekerja, jaminan sosial, dan kesejahteraan digital
contract STGSovereignLaborWelfare {
    address public governance;
    address public auditor;

    struct WorkerRight {
        uint256 id;
        string rightName;      // contoh: "Fair Wage", "Safe Workplace"
        string description;
        bool active;
        uint256 timestamp;
        bool verified;
    }

    struct SocialBenefit {
        uint256 id;
        address beneficiary;
        string benefitType;    // contoh: "Healthcare", "Retirement", "Unemployment"
        uint256 amount;        // jumlah token STG
        uint256 timestamp;
        bool active;
    }

    struct WelfareProgram {
        uint256 id;
        string programName;    // contoh: "Universal Basic Income", "Housing Support"
        uint256 budget;        // dana dalam token STG
        string status;         // "initiated", "in_progress", "completed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => WorkerRight) public rights;
    mapping(uint256 => SocialBenefit) public benefits;
    mapping(uint256 => WelfareProgram) public programs;

    uint256 public rightCount;
    uint256 public benefitCount;
    uint256 public programCount;

    event RightDeclared(uint256 id, string rightName, uint256 timestamp);
    event RightVerified(uint256 id, address auditor);
    event BenefitIssued(uint256 id, address beneficiary, string benefitType, uint256 amount, uint256 timestamp);
    event BenefitRevoked(uint256 id, address governance);
    event ProgramInitiated(uint256 id, string programName, uint256 budget, uint256 timestamp);
    event ProgramCompleted(uint256 id, string programName);
    event ProgramVerified(uint256 id, address auditor);

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

    /// @notice Deklarasi hak pekerja baru
    function declareRight(string memory _rightName, string memory _description) external onlyGovernance {
        rightCount++;
        rights[rightCount] = WorkerRight({
            id: rightCount,
            rightName: _rightName,
            description: _description,
            active: true,
            timestamp: block.timestamp,
            verified: false
        });
        emit RightDeclared(rightCount, _rightName, block.timestamp);
    }

    /// @notice Verifikasi hak pekerja oleh auditor eksternal
    function verifyRight(uint256 _id) external onlyAuditor {
        require(_id <= rightCount, "Right tidak ada");
        rights[_id].verified = true;
        emit RightVerified(_id, msg.sender);
    }

    /// @notice Terbitkan jaminan sosial untuk warga
    function issueBenefit(address _beneficiary, string memory _benefitType, uint256 _amount) external onlyGovernance {
        benefitCount++;
        benefits[benefitCount] = SocialBenefit({
            id: benefitCount,
            beneficiary: _beneficiary,
            benefitType: _benefitType,
            amount: _amount,
            timestamp: block.timestamp,
            active: true
        });
        emit BenefitIssued(benefitCount, _beneficiary, _benefitType, _amount, block.timestamp);
    }

    /// @notice Cabut jaminan sosial
    function revokeBenefit(uint256 _id) external onlyGovernance {
        require(_id <= benefitCount, "Benefit tidak ada");
        benefits[_id].active = false;
        emit BenefitRevoked(_id, msg.sender);
    }

    /// @notice Inisiasi program kesejahteraan
    function initiateProgram(string memory _programName, uint256 _budget) external onlyGovernance {
        programCount++;
        programs[programCount] = WelfareProgram({
            id: programCount,
            programName: _programName,
            budget: _budget,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProgramInitiated(programCount, _programName, _budget, block.timestamp);
    }

    /// @notice Tandai program kesejahteraan selesai
    function completeProgram(uint256 _id) external onlyGovernance {
        require(_id <= programCount, "Program tidak ada");
        programs[_id].status = "completed";
        emit ProgramCompleted(_id, programs[_id].programName);
    }

    /// @notice Verifikasi program kesejahteraan oleh auditor eksternal
    function verifyProgram(uint256 _id) external onlyAuditor {
        require(_id <= programCount, "Program tidak ada");
        programs[_id].verified = true;
        emit ProgramVerified(_id, msg.sender);
    }
}
