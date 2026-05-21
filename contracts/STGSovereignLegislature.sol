// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Legislature Contract
/// @notice Integrasi pembuatan undang-undang, voting parlemen digital, dan harmonisasi dengan konstitusi STG
contract STGSovereignLegislature {
    address public governance;
    address public auditor;

    struct Bill {
        uint256 id;
        string title;         // judul RUU
        string contentHash;   // hash/IPFS dari teks RUU
        uint256 yesVotes;
        uint256 noVotes;
        uint256 abstainVotes;
        uint256 timestamp;
        bool passed;
        bool ratified;
    }

    mapping(uint256 => Bill) public bills;
    uint256 public billCount;

    event BillProposed(uint256 id, string title, string contentHash, uint256 timestamp);
    event BillVoted(uint256 id, address voter, string choice);
    event BillRatified(uint256 id, address governance);

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

    /// @notice Ajukan RUU baru
    function proposeBill(string memory _title, string memory _contentHash) external onlyGovernance {
        billCount++;
        bills[billCount] = Bill({
            id: billCount,
            title: _title,
            contentHash: _contentHash,
            yesVotes: 0,
            noVotes: 0,
            abstainVotes: 0,
            timestamp: block.timestamp,
            passed: false,
            ratified: false
        });
        emit BillProposed(billCount, _title, _contentHash, block.timestamp);
    }

    /// @notice Voting parlemen digital
    function voteBill(uint256 _id, string memory _choice) external {
        require(_id <= billCount, "Bill tidak ada");
        if (keccak256(bytes(_choice)) == keccak256(bytes("yes"))) {
            bills[_id].yesVotes++;
        } else if (keccak256(bytes(_choice)) == keccak256(bytes("no"))) {
            bills[_id].noVotes++;
        } else {
            bills[_id].abstainVotes++;
        }
        emit BillVoted(_id, msg.sender, _choice);
    }

    /// @notice Ratifikasi RUU menjadi undang-undang
    function ratifyBill(uint256 _id) external onlyGovernance {
        require(_id <= billCount, "Bill tidak ada");
        Bill storage b = bills[_id];
        require(b.yesVotes > b.noVotes, "RUU tidak lolos voting");
        b.passed = true;
        b.ratified = true;
        emit BillRatified(_id, msg.sender);
    }
}
