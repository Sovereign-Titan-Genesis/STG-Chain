// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Welfare Contract
/// @notice Integrasi jaminan sosial, bantuan warga, dan sistem kesejahteraan on-chain
contract STGSovereignWelfare {
    address public governance;
    address public auditor;

    struct SocialGuarantee {
        uint256 id;
        address citizen;
        string program;        // contoh: "Universal Basic Income", "Pension"
        uint256 amount;        // jumlah token STG
        string status;         // "granted", "revoked"
        uint256 timestamp;
        bool verified;
    }

    struct CitizenAid {
        uint256 id;
        address beneficiary;
        string aidType;        // contoh: "Food Assistance", "Housing Aid"
        uint256 amount;
        string status;         // "issued", "revoked"
        uint256 timestamp;
        bool verified;
    }

    struct WelfareProgram {
        uint256 id;
        string name;           // contoh: "Healthcare Subsidy Program"
        string description;
        string status;         // "active", "suspended"
        uint256 budget;
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => SocialGuarantee) public guarantees;
    mapping(uint256 => CitizenAid) public aids;
    mapping(uint256 => WelfareProgram) public programs;

    uint256 public guaranteeCount;
    uint256 public aidCount;
    uint256 public programCount;

    event GuaranteeGranted(uint256 id, address citizen, string program, uint256 amount, uint256 timestamp);
    event GuaranteeRevoked(uint256 id, address citizen);
    event AidIssued(uint256 id, address beneficiary, string aidType, uint256 amount, uint256 timestamp);
    event AidRevoked(uint256 id, address beneficiary);
    event ProgramCreated(uint256 id, string name, uint256 budget, uint256 timestamp);
    event ProgramSuspended(uint256 id, string name);
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

    /// @notice Berikan jaminan sosial kepada warga
    function grantGuarantee(address _citizen, string memory _program, uint256 _amount) external onlyGovernance {
        guaranteeCount++;
        guarantees[guaranteeCount] = SocialGuarantee({
            id: guaranteeCount,
            citizen: _citizen,
            program: _program,
            amount: _amount,
            status: "granted",
            timestamp: block.timestamp,
            verified: false
        });
        emit GuaranteeGranted(guaranteeCount, _citizen, _program, _amount, block.timestamp);
    }

    /// @notice Cabut jaminan sosial
    function revokeGuarantee(uint256 _id) external onlyGovernance {
        require(_id <= guaranteeCount, "Guarantee tidak ada");
        guarantees[_id].status = "revoked";
        emit GuaranteeRevoked(_id, guarantees[_id].citizen);
    }

    /// @notice Terbitkan bantuan warga
    function issueAid(address _beneficiary, string memory _aidType, uint256 _amount) external onlyGovernance {
        aidCount++;
        aids[aidCount] = CitizenAid({
            id: aidCount,
            beneficiary: _beneficiary,
            aidType: _aidType,
            amount: _amount,
            status: "issued",
            timestamp: block.timestamp,
            verified: false
        });
        emit AidIssued(aidCount, _beneficiary, _aidType, _amount, block.timestamp);
    }

    /// @notice Cabut bantuan warga
    function revokeAid(uint256 _id) external onlyGovernance {
        require(_id <= aidCount, "Aid tidak ada");
        aids[_id].status = "revoked";
        emit AidRevoked(_id, aids[_id].beneficiary);
    }

    /// @notice Buat program kesejahteraan baru
    function createProgram(string memory _name, string memory _description, uint256 _budget) external onlyGovernance {
        programCount++;
        programs[programCount] = WelfareProgram({
            id: programCount,
            name: _name,
            description: _description,
            status: "active",
            budget: _budget,
            timestamp: block.timestamp,
            verified: false
        });
        emit ProgramCreated(programCount, _name, _budget, block.timestamp);
    }

    /// @notice Suspend program kesejahteraan
    function suspendProgram(uint256 _id) external onlyGovernance {
        require(_id <= programCount, "Program tidak ada");
        programs[_id].status = "suspended";
        emit ProgramSuspended(_id, programs[_id].name);
    }

    /// @notice Verifikasi jaminan/bantuan/program oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("guarantee"))) {
            require(_id <= guaranteeCount, "Guarantee tidak ada");
            guarantees[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("aid"))) {
            require(_id <= aidCount, "Aid tidak ada");
            aids[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("program"))) {
            require(_id <= programCount, "Program tidak ada");
            programs[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
