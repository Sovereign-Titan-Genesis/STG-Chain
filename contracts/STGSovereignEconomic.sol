// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Economic Contract
/// @notice Integrasi kebijakan fiskal, moneter, dan perdagangan digital
contract STGSovereignEconomic {
    address public governance;
    address public auditor;

    struct FiscalPolicy {
        uint256 id;
        string policy;        // contoh: "Tax Reform", "Budget Allocation"
        uint256 amount;       // jumlah dana dalam token STG
        string status;        // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    struct MonetaryPolicy {
        uint256 id;
        string measure;       // contoh: "Interest Rate Adjustment", "Liquidity Injection"
        uint256 value;        // nilai kebijakan (misal: suku bunga, jumlah token)
        string status;
        uint256 timestamp;
        bool verified;
    }

    struct TradeAgreement {
        uint256 id;
        string partner;       // mitra dagang digital/internasional
        string agreementHash; // hash/IPFS perjanjian perdagangan
        string status;        // "proposed", "ratified"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => FiscalPolicy) public fiscalPolicies;
    mapping(uint256 => MonetaryPolicy) public monetaryPolicies;
    mapping(uint256 => TradeAgreement) public tradeAgreements;

    uint256 public fiscalCount;
    uint256 public monetaryCount;
    uint256 public tradeCount;

    event FiscalPolicyProposed(uint256 id, string policy, uint256 amount, uint256 timestamp);
    event FiscalPolicyExecuted(uint256 id, string policy);
    event MonetaryPolicyProposed(uint256 id, string measure, uint256 value, uint256 timestamp);
    event MonetaryPolicyExecuted(uint256 id, string measure);
    event TradeAgreementProposed(uint256 id, string partner, uint256 timestamp);
    event TradeAgreementRatified(uint256 id, string partner);
    event PolicyVerified(uint256 id, string category, address auditor);

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

    /// @notice Ajukan kebijakan fiskal baru
    function proposeFiscalPolicy(string memory _policy, uint256 _amount) external onlyGovernance {
        fiscalCount++;
        fiscalPolicies[fiscalCount] = FiscalPolicy({
            id: fiscalCount,
            policy: _policy,
            amount: _amount,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit FiscalPolicyProposed(fiscalCount, _policy, _amount, block.timestamp);
    }

    /// @notice Eksekusi kebijakan fiskal
    function executeFiscalPolicy(uint256 _id) external onlyGovernance {
        require(_id <= fiscalCount, "Policy tidak ada");
        fiscalPolicies[_id].status = "executed";
        emit FiscalPolicyExecuted(_id, fiscalPolicies[_id].policy);
    }

    /// @notice Ajukan kebijakan moneter baru
    function proposeMonetaryPolicy(string memory _measure, uint256 _value) external onlyGovernance {
        monetaryCount++;
        monetaryPolicies[monetaryCount] = MonetaryPolicy({
            id: monetaryCount,
            measure: _measure,
            value: _value,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit MonetaryPolicyProposed(monetaryCount, _measure, _value, block.timestamp);
    }

    /// @notice Eksekusi kebijakan moneter
    function executeMonetaryPolicy(uint256 _id) external onlyGovernance {
        require(_id <= monetaryCount, "Policy tidak ada");
        monetaryPolicies[_id].status = "executed";
        emit MonetaryPolicyExecuted(_id, monetaryPolicies[_id].measure);
    }

    /// @notice Ajukan perjanjian perdagangan digital
    function proposeTradeAgreement(string memory _partner, string memory _agreementHash) external onlyGovernance {
        tradeCount++;
        tradeAgreements[tradeCount] = TradeAgreement({
            id: tradeCount,
            partner: _partner,
            agreementHash: _agreementHash,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit TradeAgreementProposed(tradeCount, _partner, block.timestamp);
    }

    /// @notice Ratifikasi perjanjian perdagangan
    function ratifyTradeAgreement(uint256 _id) external onlyGovernance {
        require(_id <= tradeCount, "Agreement tidak ada");
        tradeAgreements[_id].status = "ratified";
        emit TradeAgreementRatified(_id, tradeAgreements[_id].partner);
    }

    /// @notice Verifikasi kebijakan oleh auditor eksternal
    function verifyPolicy(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("fiscal"))) {
            require(_id <= fiscalCount, "Fiscal policy tidak ada");
            fiscalPolicies[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("monetary"))) {
            require(_id <= monetaryCount, "Monetary policy tidak ada");
            monetaryPolicies[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("trade"))) {
            require(_id <= tradeCount, "Trade agreement tidak ada");
            tradeAgreements[_id].verified = true;
        }
        emit PolicyVerified(_id, _category, msg.sender);
    }
}
