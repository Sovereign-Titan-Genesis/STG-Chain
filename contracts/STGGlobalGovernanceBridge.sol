// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Global Governance Bridge Contract
/// @notice Sinkronisasi STG-Chain dengan entitas global/regional (ASEAN, EU, UN DAO)
contract STGGlobalGovernanceBridge {
    address public governance;
    address public auditor;

    struct BridgeProposal {
        uint256 id;
        string entity;        // contoh: "ASEAN", "EU", "UN DAO"
        string action;        // contoh: "policy_sync", "fund_transfer", "joint_vote"
        string reference;     // hash/ID dari proposal lintas entitas
        uint256 timestamp;
        bool executed;
        bool verified;
    }

    mapping(uint256 => BridgeProposal) public proposals;
    uint256 public proposalCount;

    event BridgeProposalSubmitted(uint256 id, string entity, string action, string reference, uint256 timestamp);
    event BridgeProposalExecuted(uint256 id, string entity, string action);
    event BridgeProposalVerified(uint256 id, address auditor);

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

    /// @notice Submit proposal sinkronisasi lintas entitas global
    function submitProposal(string memory _entity, string memory _action, string memory _reference) external onlyGovernance {
        proposalCount++;
        proposals[proposalCount] = BridgeProposal({
            id: proposalCount,
            entity: _entity,
            action: _action,
            reference: _reference,
            timestamp: block.timestamp,
            executed: false,
            verified: false
        });
        emit BridgeProposalSubmitted(proposalCount, _entity, _action, _reference, block.timestamp);
    }

    /// @notice Eksekusi proposal lintas entitas global
    function executeProposal(uint256 _id) external onlyGovernance {
        BridgeProposal storage bp = proposals[_id];
        require(!bp.executed, "Sudah dieksekusi");
        bp.executed = true;
        emit BridgeProposalExecuted(_id, bp.entity, bp.action);
    }

    /// @notice Verifikasi proposal lintas entitas global oleh auditor eksternal
    function verifyProposal(uint256 _id) external onlyAuditor {
        require(_id <= proposalCount, "Proposal tidak ada");
        proposals[_id].verified = true;
        emit BridgeProposalVerified(_id, msg.sender);
    }
}
