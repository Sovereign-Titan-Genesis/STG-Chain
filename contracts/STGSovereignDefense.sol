// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Defense Contract
/// @notice Integrasi keamanan nasional, cyber defense, dan koordinasi militer digital
contract STGSovereignDefense {
    address public governance;
    address public auditor;

    struct DefenseOperation {
        uint256 id;
        string operation;     // contoh: "CyberShield", "BorderDefense", "EmergencyResponse"
        string unit;          // unit/kementerian digital yang bertanggung jawab
        string status;        // contoh: "initiated", "active", "completed"
        uint256 riskLevel;    // level risiko (0-100)
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => DefenseOperation) public operations;
    uint256 public operationCount;

    event OperationInitiated(uint256 id, string operation, string unit, uint256 riskLevel, uint256 timestamp);
    event OperationCompleted(uint256 id, string operation, string unit);
    event OperationVerified(uint256 id, address auditor);

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

    /// @notice Inisiasi operasi pertahanan baru
    function initiateOperation(string memory _operation, string memory _unit, uint256 _riskLevel) external onlyGovernance {
        operationCount++;
        operations[operationCount] = DefenseOperation({
            id: operationCount,
            operation: _operation,
            unit: _unit,
            status: "initiated",
            riskLevel: _riskLevel,
            timestamp: block.timestamp,
            verified: false
        });
        emit OperationInitiated(operationCount, _operation, _unit, _riskLevel, block.timestamp);
    }

    /// @notice Tandai operasi sebagai selesai
    function completeOperation(uint256 _id) external onlyGovernance {
        require(_id <= operationCount, "Operation tidak ada");
        operations[_id].status = "completed";
        emit OperationCompleted(_id, operations[_id].operation, operations[_id].unit);
    }

    /// @notice Verifikasi operasi pertahanan oleh auditor eksternal
    function verifyOperation(uint256 _id) external onlyAuditor {
        require(_id <= operationCount, "Operation tidak ada");
        operations[_id].verified = true;
        emit OperationVerified(_id, msg.sender);
    }
}
