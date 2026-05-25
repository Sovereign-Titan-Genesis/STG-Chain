// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Health Contract
/// @notice Integrasi layanan kesehatan digital, rekam medis on-chain, dan sistem kesejahteraan medis berdaulat
contract STGSovereignHealth {
    address public governance;
    address public auditor;

    struct MedicalRecord {
        uint256 id;
        address citizen;
        string recordHash;     // IPFS hash rekam medis
        string status;         // "active", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct HealthService {
        uint256 id;
        string serviceName;    // contoh: "Telemedicine Consultation"
        string description;
        string status;         // "available", "unavailable"
        uint256 timestamp;
        bool verified;
    }

    struct WelfareSupport {
        uint256 id;
        address citizen;
        string supportType;    // contoh: "Healthcare Subsidy"
        uint256 amount;
        string status;         // "granted", "revoked"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => MedicalRecord) public records;
    mapping(uint256 => HealthService) public services;
    mapping(uint256 => WelfareSupport) public supports;

    uint256 public recordCount;
    uint256 public serviceCount;
    uint256 public supportCount;

    event RecordCreated(uint256 id, address citizen, string recordHash, uint256 timestamp);
    event ServicePublished(uint256 id, string serviceName, uint256 timestamp);
    event SupportGranted(uint256 id, address citizen, string supportType, uint256 amount, uint256 timestamp);
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

    /// @notice Buat rekam medis digital warga
    function createRecord(address _citizen, string memory _recordHash) external onlyGovernance {
        recordCount++;
        records[recordCount] = MedicalRecord({
            id: recordCount,
            citizen: _citizen,
            recordHash: _recordHash,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit RecordCreated(recordCount, _citizen, _recordHash, block.timestamp);
    }

    /// @notice Publikasikan layanan kesehatan digital
    function publishService(string memory _serviceName, string memory _description) external onlyGovernance {
        serviceCount++;
        services[serviceCount] = HealthService({
            id: serviceCount,
            serviceName: _serviceName,
            description: _description,
            status: "available",
            timestamp: block.timestamp,
            verified: false
        });
        emit ServicePublished(serviceCount, _serviceName, block.timestamp);
    }

    /// @notice Berikan dukungan kesejahteraan medis
    function grantSupport(address _citizen, string memory _supportType, uint256 _amount) external onlyGovernance {
        supportCount++;
        supports[supportCount] = WelfareSupport({
            id: supportCount,
            citizen: _citizen,
            supportType: _supportType,
            amount: _amount,
            status: "granted",
            timestamp: block.timestamp,
            verified: false
        });
        emit SupportGranted(supportCount, _citizen, _supportType, _amount, block.timestamp);
    }

    /// @notice Verifikasi record/service/support oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("record"))) {
            require(_id <= recordCount, "Record tidak ada");
            records[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("service"))) {
            require(_id <= serviceCount, "Service tidak ada");
            services[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("support"))) {
            require(_id <= supportCount, "Support tidak ada");
            supports[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
