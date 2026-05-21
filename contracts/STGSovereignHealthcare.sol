// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Healthcare Contract
/// @notice Integrasi layanan kesehatan digital, rekam medis on-chain, dan sistem asuransi berdaulat
contract STGSovereignHealthcare {
    address public governance;
    address public auditor;

    struct MedicalRecord {
        uint256 id;
        address patient;
        string recordHash;     // hash/IPFS rekam medis
        uint256 timestamp;
        bool verified;
    }

    struct InsurancePolicy {
        uint256 id;
        address holder;
        string coverage;       // cakupan: "basic", "extended", "universal"
        uint256 premium;       // premi dalam token STG
        uint256 timestamp;
        bool active;
    }

    mapping(uint256 => MedicalRecord) public records;
    mapping(uint256 => InsurancePolicy) public policies;
    uint256 public recordCount;
    uint256 public policyCount;

    event RecordCreated(uint256 id, address patient, uint256 timestamp);
    event RecordVerified(uint256 id, address auditor);
    event PolicyIssued(uint256 id, address holder, string coverage, uint256 premium, uint256 timestamp);
    event PolicyUpdated(uint256 id, string coverage, uint256 premium);
    event PolicyRevoked(uint256 id, address governance);

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

    /// @notice Buat rekam medis baru
    function createRecord(address _patient, string memory _recordHash) external onlyGovernance {
        recordCount++;
        records[recordCount] = MedicalRecord({
            id: recordCount,
            patient: _patient,
            recordHash: _recordHash,
            timestamp: block.timestamp,
            verified: false
        });
        emit RecordCreated(recordCount, _patient, block.timestamp);
    }

    /// @notice Verifikasi rekam medis oleh auditor eksternal
    function verifyRecord(uint256 _id) external onlyAuditor {
        require(_id <= recordCount, "Record tidak ada");
        records[_id].verified = true;
        emit RecordVerified(_id, msg.sender);
    }

    /// @notice Terbitkan polis asuransi kesehatan
    function issuePolicy(address _holder, string memory _coverage, uint256 _premium) external onlyGovernance {
        policyCount++;
        policies[policyCount] = InsurancePolicy({
            id: policyCount,
            holder: _holder,
            coverage: _coverage,
            premium: _premium,
            timestamp: block.timestamp,
            active: true
        });
        emit PolicyIssued(policyCount, _holder, _coverage, _premium, block.timestamp);
    }

    /// @notice Update polis asuransi kesehatan
    function updatePolicy(uint256 _id, string memory _coverage, uint256 _premium) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].coverage = _coverage;
        policies[_id].premium = _premium;
        policies[_id].timestamp = block.timestamp;
        emit PolicyUpdated(_id, _coverage, _premium);
    }

    /// @notice Cabut polis asuransi kesehatan
    function revokePolicy(uint256 _id) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].active = false;
        emit PolicyRevoked(_id, msg.sender);
    }
}
