// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Validator Monitoring Contract
/// @notice Integrasi node status, uptime, dan performance metrics ke dashboard
contract STGValidatorMonitoring {
    address public governance;
    address public auditor;

    struct Validator {
        uint256 id;
        address nodeAddress;
        string status;        // contoh: "active", "inactive", "slashed"
        uint256 uptime;       // dalam detik
        uint256 performance;  // skor performa (0-100)
        uint256 lastUpdate;
    }

    mapping(uint256 => Validator) public validators;
    uint256 public validatorCount;

    event ValidatorRegistered(uint256 id, address nodeAddress);
    event ValidatorUpdated(uint256 id, string status, uint256 uptime, uint256 performance, uint256 timestamp);
    event ValidatorAudited(uint256 id, address auditor, string remarks);

    modifier onlyGovernance() {
        require(msg.sender == governance, "Hanya governance");
        _;
    }

    modifier onlyAuditor() {
        require(msg.sender == auditor, "Hanya auditor");
        _;
    }

    constructor(address _governance, address _auditor) {
        governance = _governance;
        auditor = _auditor;
    }

    /// @notice Registrasi validator baru
    function registerValidator(address _nodeAddress) external onlyGovernance {
        validatorCount++;
        validators[validatorCount] = Validator({
            id: validatorCount,
            nodeAddress: _nodeAddress,
            status: "active",
            uptime: 0,
            performance: 100,
            lastUpdate: block.timestamp
        });
        emit ValidatorRegistered(validatorCount, _nodeAddress);
    }

    /// @notice Update status validator (uptime & performance)
    function updateValidator(uint256 _id, string memory _status, uint256 _uptime, uint256 _performance) external onlyGovernance {
        require(_id <= validatorCount, "Validator tidak ada");
        validators[_id].status = _status;
        validators[_id].uptime = _uptime;
        validators[_id].performance = _performance;
        validators[_id].lastUpdate = block.timestamp;
        emit ValidatorUpdated(_id, _status, _uptime, _performance, block.timestamp);
    }

    /// @notice Audit validator oleh auditor eksternal
    function auditValidator(uint256 _id, string memory _remarks) external onlyAuditor {
        require(_id <= validatorCount, "Validator tidak ada");
        emit ValidatorAudited(_id, msg.sender, _remarks);
    }
}
