// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Health Contract
/// @notice Integrasi layanan kesehatan digital, rekam medis on-chain, dan sistem kesejahteraan medis berdaulat
contract STGSovereignHealth {
    address public governance;
    address public auditor;

    struct HealthService {
        uint256 id;
        string name;           // contoh: "Telemedicine", "Emergency Response"
        string status;         // "active", "maintenance", "suspended"
        uint256 timestamp;
        bool verified;
    }

    struct MedicalRecord {
        uint256 id;
        address citizen;
        string recordHash;     // hash/IPFS rekam medis
        string status;         // "created", "updated", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct WelfareSupport {
        uint256 id;
        address beneficiary;
        string supportType;    // contoh: "Healthcare Subsidy", "Medicine Aid"
        uint256 amount;        // jumlah token STG
        string status;         // "issued", "revoked"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => HealthService) public services;
    mapping(uint256 => MedicalRecord) public records;
    mapping(uint256 => WelfareSupport) public supports;

    uint256 public serviceCount;
    uint256 public recordCount;
    uint256 public supportCount;

    event ServiceRegistered(uint256 id, string name, string status, uint256 timestamp);
    event ServiceVerified(uint256 id, address auditor);
    event RecordCreated(uint256 id, address citizen, uint256 timestamp);
    event RecordUpdated(uint256 id, address citizen);
    event SupportIssued(uint256 id, address beneficiary, string supportType, uint256 amount, uint256 timestamp);
    event SupportRevoked(uint256 id, address beneficiary);
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

    /// @notice Registrasi layanan kesehatan digital
    function registerService(string memory _name, string memory _status) external onlyGovernance {
        serviceCount++;
        services[serviceCount] = HealthService({
            id: serviceCount,
            name: _name,
            status: _status,
            timestamp: block.timestamp,
            verified: false
        });
        emit ServiceRegistered(serviceCount, _name, _status, block.timestamp);
    }

    /// @notice Verifikasi layanan kesehatan
    function verifyService(uint256 _id) external onlyAuditor {
        require(_id <= serviceCount, "Service tidak ada");
        services[_id].verified = true;
        emit ServiceVerified(_id, msg.sender);
    }

    /// @notice Buat rekam medis baru
    function createRecord(address _citizen, string memory _recordHash) external onlyGovernance {
        recordCount++;
        records[recordCount] = MedicalRecord({
            id: recordCount,
            citizen: _citizen,
            recordHash: _recordHash,
            status: "created",
            timestamp: block.timestamp,
            verified: false
        });
        emit RecordCreated(recordCount, _citizen, block.timestamp);
    }

    /// @notice Update rekam medis
    function updateRecord(uint256 _id, string memory _recordHash) external onlyGovernance {
        require(_id <= recordCount, "Record tidak ada");
        records[_id].recordHash = _recordHash;
        records[_id].status = "updated";
        emit RecordUpdated(_id, records[_id].citizen);
    }

    /// @notice Terbitkan dukungan kesejahteraan medis
    function issueSupport(address _beneficiary, string memory _supportType, uint256 _amount) external onlyGovernance {
        supportCount++;
        supports[supportCount] = WelfareSupport({
            id: supportCount,
            beneficiary: _beneficiary,
            supportType: _supportType,
            amount: _amount,
            status: "issued",
            timestamp: block.timestamp,
            verified: false
        });
        emit SupportIssued(supportCount, _beneficiary, _supportType, _amount, block.timestamp);
    }

    /// @notice Cabut dukungan kesejahteraan medis
    function revokeSupport(uint256 _id) external onlyGovernance {
        require(_id <= supportCount, "Support tidak ada");
        supports[_id].status = "revoked";
        emit SupportRevoked(_id, supports[_id].beneficiary);
    }

    /// @notice Verifikasi record/support oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("service"))) {
            require(_id <= serviceCount, "Service tidak ada");
            services[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("record"))) {
            require(_id <= recordCount, "Record tidak ada");
            records[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("support"))) {
            require(_id <= supportCount, "Support tidak ada");
            supports[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}

