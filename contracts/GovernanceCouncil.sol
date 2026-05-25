// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract GovernanceCouncil is AccessControl {
    bytes32 public constant COUNCIL_ROLE = keccak256("COUNCIL_ROLE");

    uint public requiredApprovals;

    struct Proposal {
        bytes32 txHash;
        uint256 approvals;
        bool executed;
        mapping(address => bool) approvedBy;
    }

    mapping(bytes32 => Proposal) public proposals;

    event ProposalCreated(bytes32 indexed txHash, address proposer);
    event ProposalApproved(bytes32 indexed txHash, address approver, uint approvals);
    event ProposalExecuted(bytes32 indexed txHash);

    constructor(uint _requiredApprovals) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        requiredApprovals = _requiredApprovals;
    }

    function createProposal(bytes32 txHash) external onlyRole(COUNCIL_ROLE) {
        Proposal storage p = proposals[txHash];
        require(p.txHash == 0, "Proposal already exists");
        p.txHash = txHash;
        p.approvals = 0;
        p.executed = false;
        emit ProposalCreated(txHash, msg.sender);
    }

    function approveProposal(bytes32 txHash) external onlyRole(COUNCIL_ROLE) {
        Proposal storage p = proposals[txHash];
        require(p.txHash != 0, "Proposal not found");
        require(!p.approvedBy[msg.sender], "Already approved");
        require(!p.executed, "Already executed");

        p.approvedBy[msg.sender] = true;
        p.approvals += 1;
        emit ProposalApproved(txHash, msg.sender, p.approvals);
    }

    function executeProposal(bytes32 txHash) external onlyRole(COUNCIL_ROLE) {
        Proposal storage p = proposals[txHash];
        require(p.txHash != 0, "Proposal not found");
        require(!p.executed, "Already executed");
        require(p.approvals >= requiredApprovals, "Not enough approvals");

        p.executed = true;
        emit ProposalExecuted(txHash);
        // Di sini bisa dipanggil registry atau vault untuk eksekusi aksi nyata
    }
}
