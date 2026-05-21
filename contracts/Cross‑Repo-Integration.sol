// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Cross-Repo Integration Contract
/// @notice Sinkronisasi STG-Unified, STG-Chain, STG-Web3, dan Bio-Server
contract STGCrossRepoIntegration {
    address public governance;
    address public auditor;

    struct RepoSync {
        uint256 id;
        string repoName;     // contoh: "STG-Chain", "STG-Web3"
        string action;       // contoh: "update", "deploy", "audit"
        uint256 timestamp;
        bool executed;
    }

    mapping(uint256 => RepoSync) public syncLogs;
    uint256 public syncCount;

    event RepoSyncInitiated(uint256 id, string repoName, string action, uint256 timestamp);
    event RepoSyncExecuted(uint256 id, string repoName, string action);
    event RepoSyncAudited(uint256 id, address auditor, string remarks);

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

    /// @notice Inisiasi sinkronisasi lintas repo
    function initiateSync(string memory _repoName, string memory _action) external onlyGovernance {
        syncCount++;
        syncLogs[syncCount] = RepoSync({
            id: syncCount,
            repoName: _repoName,
            action: _action,
            timestamp: block.timestamp,
            executed: false
        });
        emit RepoSyncInitiated(syncCount, _repoName, _action, block.timestamp);
    }

    /// @notice Eksekusi sinkronisasi lintas repo
    function executeSync(uint256 _id) external onlyGovernance {
        RepoSync storage sync = syncLogs[_id];
        require(!sync.executed, "Sudah dieksekusi");
        sync.executed = true;
        emit RepoSyncExecuted(_id, sync.repoName, sync.action);
    }

    /// @notice Audit sinkronisasi lintas repo
    function auditSync(uint256 _id, string memory _remarks) external onlyAuditor {
        require(_id <= syncCount, "Sync tidak ada");
        emit RepoSyncAudited(_id, msg.sender, _remarks);
    }
}


