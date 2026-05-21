// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Justice & Human Rights Contract
/// @notice Integrasi hak asasi digital, perlindungan warga, dan keadilan sosial on-chain
contract STGSovereignJusticeHumanRights {
    address public governance;
    address public auditor;

    struct Right {
        uint256 id;
        string name;           // contoh: "Freedom of Speech", "Right to Privacy"
        string description;    // deskripsi hak
        bool active;
        uint256 timestamp;
        bool verified;
    }

    struct Complaint {
        uint256 id;
        address citizen;
        string issue;          // contoh: "Discrimination", "Censorship"
        string status;         // "filed", "in_review", "resolved"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Right) public rights;
    mapping(uint256 => Complaint) public complaints;

    uint256 public rightCount;
    uint256 public complaintCount;

    event RightDeclared(uint256 id, string name, uint256 timestamp);
    event RightVerified(uint256 id, address auditor);
    event ComplaintFiled(uint256 id, address citizen, string issue, uint256 timestamp);
    event ComplaintResolved(uint256 id, string issue);
    event ComplaintVerified(uint256 id, address auditor);

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

    /// @notice Deklarasi hak asasi digital baru
    function declareRight(string memory _name, string memory _description) external onlyGovernance {
        rightCount++;
        rights[rightCount] = Right({
            id: rightCount,
            name: _name,
            description: _description,
            active: true,
            timestamp: block.timestamp,
            verified: false
        });
        emit RightDeclared(rightCount, _name, block.timestamp);
    }

    /// @notice Verifikasi hak asasi oleh auditor eksternal
    function verifyRight(uint256 _id) external onlyAuditor {
        require(_id <= rightCount, "Right tidak ada");
        rights[_id].verified = true;
        emit RightVerified(_id, msg.sender);
    }

    /// @notice Ajukan pengaduan pelanggaran hak
    function fileComplaint(string memory _issue) external {
        complaintCount++;
        complaints[complaintCount] = Complaint({
            id: complaintCount,
            citizen: msg.sender,
            issue: _issue,
            status: "filed",
            timestamp: block.timestamp,
            verified: false
        });
        emit ComplaintFiled(complaintCount, msg.sender, _issue, block.timestamp);
    }

    /// @notice Resolusi pengaduan oleh governance
    function resolveComplaint(uint256 _id) external onlyGovernance {
        require(_id <= complaintCount, "Complaint tidak ada");
        complaints[_id].status = "resolved";
        emit ComplaintResolved(_id, complaints[_id].issue);
    }

    /// @notice Verifikasi pengaduan oleh auditor eksternal
    function verifyComplaint(uint256 _id) external onlyAuditor {
        require(_id <= complaintCount, "Complaint tidak ada");
        complaints[_id].verified = true;
        emit ComplaintVerified(_id, msg.sender);
    }
}
