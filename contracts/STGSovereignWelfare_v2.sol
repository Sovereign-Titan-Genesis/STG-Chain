// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Welfare Contract
/// @notice Integrasi jaminan sosial, bantuan warga, dan sistem kesejahteraan berdaulat on-chain
contract STGSovereignWelfare {
    address public governance;
    address public auditor;

    struct SocialGuarantee {
        uint256 id;
        address citizen;
        string program;        // contoh: "Universal Basic Income"
        uint256 amount;
        string status;         // "granted", "revoked"
        uint256 timestamp;
        bool verified;
    }

    struct CitizenAid {
        uint256 id;
        address citizen;
        string aidType;        // contoh: "Medical Assistance", "Food Aid"
        uint256 amount;
        string status;         // "distributed", "pending"
        uint256 timestamp;
        bool verified;
    }

    struct WelfarePolicy {
        uint256 id;
        string title;          // contoh: "Healthcare Subsidy Policy"
        string description;
        string status;         // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => SocialGuarantee) public guarantees;
    mapping(uint256 => CitizenAid) public aids;
    mapping(uint256 => WelfarePolicy) public policies;

    uint256 public guaranteeCount;
    uint256 public aidCount;
    uint256 public policyCount;

    event GuaranteeGranted(uint256 id, address citizen, string program, uint256 amount, uint256 timestamp);
    event GuaranteeRevoked(uint256 id, address citizen);
    event AidDistributed(uint256 id, address citizen, string aidType, uint256 amount, uint256 timestamp);
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

    /// @notice Distribusikan bantuan warga
    function distributeAid(address _citizen, string memory _aidType, uint256 _amount) external onlyGovernance {
        aidCount++;
        aids[aidCount] = CitizenAid({
            id: aidCount,
            citizen: _citizen,
            aidType: _aidType,
            amount: _amount,
            status: "distributed",
            timestamp: block.timestamp,
            verified: false
        });
        emit AidDistributed(aidCount, _citizen, _aidType, _amount, block.timestamp);
    }

    /// @notice Ajukan kebijakan kesejahteraan
    function proposePolicy(string memory _title, string memory _description) external onlyGovernance {
        policyCount++;
        policies[policyCount] = WelfarePolicy({
            id: policyCount,
            title: _title,
            description: _description,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit PolicyProposed(policyCount, _title, block.timestamp);
    }

    /// @notice Eksekusi kebijakan kesejahteraan
    function executePolicy(uint256 _id) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].status = "executed";
        emit PolicyExecuted(_id, policies[_id].title);
    }

    /// @notice Verifikasi guarantee/aid/policy oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("guarantee"))) {
            require(_id <= guaranteeCount, "Guarantee tidak ada");
            guarantees[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("aid"))) {
            require(_id <= aidCount, "Aid tidak ada");
            aids[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("policy"))) {
            require(_id <= policyCount, "Policy tidak ada");
            policies[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
