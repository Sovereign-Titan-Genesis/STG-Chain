// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Governance Contract
/// @notice Integrasi sistem pemilu digital, voting warga, dan tata kelola berdaulat on-chain
contract STGSovereignGovernance {
    address public governance;
    address public auditor;

    struct Election {
        uint256 id;
        string title;          // contoh: "General Election 2026"
        string description;
        string status;         // "scheduled", "ongoing", "completed"
        uint256 startTime;
        uint256 endTime;
        bool verified;
    }

    struct Vote {
        uint256 id;
        uint256 electionId;
        address voter;
        string candidate;
        uint256 timestamp;
        bool verified;
    }

    struct GovernanceDecision {
        uint256 id;
        string proposal;       // contoh: "Budget Allocation for Education"
        string status;         // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Election) public elections;
    mapping(uint256 => Vote) public votes;
    mapping(uint256 => GovernanceDecision) public decisions;

    uint256 public electionCount;
    uint256 public voteCount;
    uint256 public decisionCount;

    event ElectionScheduled(uint256 id, string title, uint256 startTime, uint256 endTime);
    event ElectionVerified(uint256 id, address auditor);
    event VoteCast(uint256 id, uint256 electionId, address voter, string candidate, uint256 timestamp);
    event DecisionProposed(uint256 id, string proposal, uint256 timestamp);
    event DecisionApproved(uint256 id, string proposal);
    event DecisionExecuted(uint256 id, string proposal);
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

    /// @notice Jadwalkan pemilu digital
    function scheduleElection(string memory _title, string memory _description, uint256 _startTime, uint256 _endTime) external onlyGovernance {
        electionCount++;
        elections[electionCount] = Election({
            id: electionCount,
            title: _title,
            description: _description,
            status: "scheduled",
            startTime: _startTime,
            endTime: _endTime,
            verified: false
        });
        emit ElectionScheduled(electionCount, _title, _startTime, _endTime);
    }

    /// @notice Verifikasi pemilu oleh auditor eksternal
    function verifyElection(uint256 _id) external onlyAuditor {
        require(_id <= electionCount, "Election tidak ada");
        elections[_id].verified = true;
        emit ElectionVerified(_id, msg.sender);
    }

    /// @notice Warga memberikan suara
    function castVote(uint256 _electionId, string memory _candidate) external {
        require(_electionId <= electionCount, "Election tidak ada");
        voteCount++;
        votes[voteCount] = Vote({
            id: voteCount,
            electionId: _electionId,
            voter: msg.sender,
            candidate: _candidate,
            timestamp: block.timestamp,
            verified: false
        });
        emit VoteCast(voteCount, _electionId, msg.sender, _candidate, block.timestamp);
    }

    /// @notice Ajukan keputusan tata kelola
    function proposeDecision(string memory _proposal) external onlyGovernance {
        decisionCount++;
        decisions[decisionCount] = GovernanceDecision({
            id: decisionCount,
            proposal: _proposal,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit DecisionProposed(decisionCount, _proposal, block.timestamp);
    }

    /// @notice Setujui keputusan tata kelola
    function approveDecision(uint256 _id) external onlyGovernance {
        require(_id <= decisionCount, "Decision tidak ada");
        decisions[_id].status = "approved";
        emit DecisionApproved(_id, decisions[_id].proposal);
    }

    /// @notice Eksekusi keputusan tata kelola
    function executeDecision(uint256 _id) external onlyGovernance {
        require(_id <= decisionCount, "Decision tidak ada");
        decisions[_id].status = "executed";
        emit DecisionExecuted(_id, decisions[_id].proposal);
    }

    /// @notice Verifikasi vote/decision oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("vote"))) {
            require(_id <= voteCount, "Vote tidak ada");
            votes[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("decision"))) {
            require(_id <= decisionCount, "Decision tidak ada");
            decisions[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
