// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Constitution Contract
/// @notice Integrasi prinsip dasar, hukum, dan tata kelola STG ke dalam smart contract
contract STGSovereignConstitution {
    address public governance;
    address public auditor;

    struct Article {
        uint256 id;
        string principle;     // contoh: "Democracy", "Sustainability", "Sovereignty"
        string law;           // teks hukum/aturan dasar
        uint256 timestamp;
        bool ratified;
    }

    mapping(uint256 => Article) public articles;
    uint256 public articleCount;

    event ArticleProposed(uint256 id, string principle, string law, uint256 timestamp);
    event ArticleRatified(uint256 id, address governance);
    event ArticleAudited(uint256 id, address auditor, string remarks);

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

    /// @notice Ajukan pasal konstitusi baru
    function proposeArticle(string memory _principle, string memory _law) external onlyGovernance {
        articleCount++;
        articles[articleCount] = Article({
            id: articleCount,
            principle: _principle,
            law: _law,
            timestamp: block.timestamp,
            ratified: false
        });
        emit ArticleProposed(articleCount, _principle, _law, block.timestamp);
    }

    /// @notice Ratifikasi pasal konstitusi
    function ratifyArticle(uint256 _id) external onlyGovernance {
        require(_id <= articleCount, "Article tidak ada");
        articles[_id].ratified = true;
        emit ArticleRatified(_id, msg.sender);
    }

    /// @notice Audit pasal konstitusi oleh auditor eksternal
    function auditArticle(uint256 _id, string memory _remarks) external onlyAuditor {
        require(_id <= articleCount, "Article tidak ada");
        emit ArticleAudited(_id, msg.sender, _remarks);
    }
}
