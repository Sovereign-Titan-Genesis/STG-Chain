// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Governance Contract
/// @notice Blueprint untuk proposal, voting, dan eksekusi di STG-Chain
contract STGGovernance {
    struct Proposal {
        uint256 id;
        address proposer;
        string description;
        uint256 deadline;
        uint256 yesVotes;
        uint256 noVotes;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(address => mapping(uint256 => bool)) public hasVoted;
    uint256 public proposalCount;

    event ProposalCreated(uint256 id, address proposer, string description, uint256 deadline);
    event VoteCast(address voter, uint256 proposalId, bool support);
    event ProposalExecuted(uint256 id, bool passed);

    /// @notice Membuat proposal baru
    function createProposal(string memory _description, uint256 _duration) external {
        proposalCount++;
        proposals[proposalCount] = Proposal({
            id: proposalCount,
            proposer: msg.sender,
            description: _description,
            deadline: block.timestamp + _duration,
            yesVotes: 0,
            noVotes: 0,
            executed: false
        });
        emit ProposalCreated(proposalCount, msg.sender, _description, block.timestamp + _duration);
    }

    /// @notice Voting untuk proposal
    function vote(uint256 _proposalId, bool _support) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp <= proposal.deadline, "Voting period ended");
        require(!hasVoted[msg.sender][_proposalId], "Already voted");

        hasVoted[msg.sender][_proposalId] = true;
        if (_support) {
            proposal.yesVotes++;
        } else {
            proposal.noVotes++;
        }
        emit VoteCast(msg.sender, _proposalId, _support);
    }

    /// @notice Eksekusi proposal setelah voting selesai
    function executeProposal(uint256 _proposalId) external {
        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp > proposal.deadline, "Voting still active");
        require(!proposal.executed, "Already executed");

        proposal.executed = true;
        bool passed = proposal.yesVotes > proposal.noVotes;
        emit ProposalExecuted(_proposalId, passed);

        // Di sini bisa ditambahkan logika eksekusi nyata (misalnya upgrade kontrak, treasury release, dll.)
    }
}
