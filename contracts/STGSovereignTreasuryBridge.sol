// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Treasury Bridge Contract
/// @notice Sinkronisasi treasury STG dengan bank sentral digital & stablecoin global
contract STGSovereignTreasuryBridge {
    address public governance;
    address public auditor;

    struct TreasuryBridge {
        uint256 id;
        string entity;        // contoh: "FedNow", "ECB Digital Euro", "UN Stablecoin"
        string asset;         // contoh: "USD CBDC", "EUR CBDC", "Global Stablecoin"
        uint256 amount;       // jumlah aset
        string action;        // contoh: "deposit", "withdraw", "swap"
        uint256 timestamp;
        bool executed;
        bool verified;
    }

    mapping(uint256 => TreasuryBridge) public bridges;
    uint256 public bridgeCount;

    event BridgeInitiated(uint256 id, string entity, string asset, uint256 amount, string action, uint256 timestamp);
    event BridgeExecuted(uint256 id, string entity, string asset, uint256 amount, string action);
    event BridgeVerified(uint256 id, address auditor);

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

    /// @notice Inisiasi sinkronisasi treasury lintas entitas finansial global
    function initiateBridge(string memory _entity, string memory _asset, uint256 _amount, string memory _action) external onlyGovernance {
        bridgeCount++;
        bridges[bridgeCount] = TreasuryBridge({
            id: bridgeCount,
            entity: _entity,
            asset: _asset,
            amount: _amount,
            action: _action,
            timestamp: block.timestamp,
            executed: false,
            verified: false
        });
        emit BridgeInitiated(bridgeCount, _entity, _asset, _amount, _action, block.timestamp);
    }

    /// @notice Eksekusi sinkronisasi treasury
    function executeBridge(uint256 _id) external onlyGovernance {
        TreasuryBridge storage tb = bridges[_id];
        require(!tb.executed, "Sudah dieksekusi");
        tb.executed = true;
        emit BridgeExecuted(_id, tb.entity, tb.asset, tb.amount, tb.action);
    }

    /// @notice Verifikasi sinkronisasi treasury oleh auditor eksternal
    function verifyBridge(uint256 _id) external onlyAuditor {
        require(_id <= bridgeCount, "Bridge tidak ada");
        bridges[_id].verified = true;
        emit BridgeVerified(_id, msg.sender);
    }
}
