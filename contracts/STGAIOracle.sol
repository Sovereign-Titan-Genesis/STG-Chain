// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Governance AI Oracle Contract
/// @notice Integrasi machine learning, prediksi tren voting, dan rekomendasi kebijakan otomatis
contract STGAIOracle {
    address public governance;
    address public auditor;

    struct Prediction {
        uint256 id;
        string module;       // contoh: "Voting", "Treasury", "ESG"
        string trend;        // prediksi tren, misalnya "Proposal Likely to Pass"
        string recommendation; // rekomendasi kebijakan otomatis
        uint256 confidence;  // tingkat keyakinan (0-100)
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Prediction) public predictions;
    uint256 public predictionCount;

    event PredictionSubmitted(uint256 id, string module, string trend, string recommendation, uint256 confidence, uint256 timestamp);
    event PredictionVerified(uint256 id, address auditor);

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

    /// @notice Submit prediksi tren voting/kebijakan
    function submitPrediction(string memory _module, string memory _trend, string memory _recommendation, uint256 _confidence) external onlyGovernance {
        predictionCount++;
        predictions[predictionCount] = Prediction({
            id: predictionCount,
            module: _module,
            trend: _trend,
            recommendation: _recommendation,
            confidence: _confidence,
            timestamp: block.timestamp,
            verified: false
        });
        emit PredictionSubmitted(predictionCount, _module, _trend, _recommendation, _confidence, block.timestamp);
    }

    /// @notice Verifikasi prediksi oleh auditor eksternal
    function verifyPrediction(uint256 _id) external onlyAuditor {
        require(_id <= predictionCount, "Prediction tidak ada");
        predictions[_id].verified = true;
        emit PredictionVerified(_id, msg.sender);
    }
}
