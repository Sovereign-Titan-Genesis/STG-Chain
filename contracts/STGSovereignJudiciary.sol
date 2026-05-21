// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Judiciary Contract
/// @notice Integrasi sistem peradilan, arbitrase, dan penyelesaian sengketa on-chain
contract STGSovereignJudiciary {
    address public governance;
    address public auditor;

    struct Case {
        uint256 id;
        address plaintiff;
        address defendant;
        string description;   // deskripsi kasus/sengketa
        string status;        // contoh: "filed", "in_review", "resolved"
        string verdict;       // putusan akhir
        uint256 timestamp;
        bool arbitrated;
        bool verified;
    }

    mapping(uint256 => Case) public cases;
    uint256 public caseCount;

    event CaseFiled(uint256 id, address plaintiff, address defendant, string description, uint256 timestamp);
    event CaseArbitrated(uint256 id, string verdict, address governance);
    event CaseVerified(uint256 id, address auditor);

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

    /// @notice Ajukan kasus/sengketa baru
    function fileCase(address _defendant, string memory _description) external {
        caseCount++;
        cases[caseCount] = Case({
            id: caseCount,
            plaintiff: msg.sender,
            defendant: _defendant,
            description: _description,
            status: "filed",
            verdict: "",
            timestamp: block.timestamp,
            arbitrated: false,
            verified: false
        });
        emit CaseFiled(caseCount, msg.sender, _defendant, _description, block.timestamp);
    }

    /// @notice Arbitrase/putusan kasus oleh governance
    function arbitrateCase(uint256 _id, string memory _verdict) external onlyGovernance {
        require(_id <= caseCount, "Case tidak ada");
        cases[_id].status = "resolved";
        cases[_id].verdict = _verdict;
        cases[_id].arbitrated = true;
        emit CaseArbitrated(_id, _verdict, msg.sender);
    }

    /// @notice Verifikasi kasus oleh auditor eksternal
    function verifyCase(uint256 _id) external onlyAuditor {
        require(_id <= caseCount, "Case tidak ada");
        cases[_id].verified = true;
        emit CaseVerified(_id, msg.sender);
    }
}
