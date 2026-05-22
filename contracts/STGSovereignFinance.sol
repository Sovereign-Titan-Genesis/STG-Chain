// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Finance Contract
/// @notice Integrasi treasury berdaulat, pajak digital, dan sistem anggaran on-chain
contract STGSovereignFinance {
    address public governance;
    address public auditor;

    struct Treasury {
        uint256 balance;       // saldo treasury dalam token STG
        uint256 lastUpdated;
    }

    struct TaxPolicy {
        uint256 id;
        string taxType;        // contoh: "income", "corporate", "transaction"
        uint256 rate;          // persentase pajak (basis poin)
        string status;         // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    struct BudgetAllocation {
        uint256 id;
        string department;     // contoh: "Healthcare", "Education", "Defense"
        uint256 amount;        // jumlah dana dialokasikan
        string status;         // "proposed", "approved", "disbursed"
        uint256 timestamp;
        bool verified;
    }

    Treasury public treasury;
    mapping(uint256 => TaxPolicy) public taxPolicies;
    mapping(uint256 => BudgetAllocation) public budgets;

    uint256 public taxCount;
    uint256 public budgetCount;

    event TreasuryUpdated(uint256 balance, uint256 timestamp);
    event TaxPolicyProposed(uint256 id, string taxType, uint256 rate, uint256 timestamp);
    event TaxPolicyExecuted(uint256 id, string taxType);
    event BudgetProposed(uint256 id, string department, uint256 amount, uint256 timestamp);
    event BudgetDisbursed(uint256 id, string department, uint256 amount);
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
        treasury = Treasury({balance: 0, lastUpdated: block.timestamp});
    }

    /// @notice Update saldo treasury
    function updateTreasury(uint256 _amount) external onlyGovernance {
        treasury.balance += _amount;
        treasury.lastUpdated = block.timestamp;
        emit TreasuryUpdated(treasury.balance, block.timestamp);
    }

    /// @notice Ajukan kebijakan pajak baru
    function proposeTaxPolicy(string memory _taxType, uint256 _rate) external onlyGovernance {
        taxCount++;
        taxPolicies[taxCount] = TaxPolicy({
            id: taxCount,
            taxType: _taxType,
            rate: _rate,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit TaxPolicyProposed(taxCount, _taxType, _rate, block.timestamp);
    }

    /// @notice Eksekusi kebijakan pajak
    function executeTaxPolicy(uint256 _id) external onlyGovernance {
        require(_id <= taxCount, "Tax policy tidak ada");
        taxPolicies[_id].status = "executed";
        emit TaxPolicyExecuted(_id, taxPolicies[_id].taxType);
    }

    /// @notice Ajukan alokasi anggaran
    function proposeBudget(string memory _department, uint256 _amount) external onlyGovernance {
        budgetCount++;
        budgets[budgetCount] = BudgetAllocation({
            id: budgetCount,
            department: _department,
            amount: _amount,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit BudgetProposed(budgetCount, _department, _amount, block.timestamp);
    }

    /// @notice Disburse anggaran ke departemen
    function disburseBudget(uint256 _id) external onlyGovernance {
        require(_id <= budgetCount, "Budget tidak ada");
        budgets[_id].status = "disbursed";
        treasury.balance -= budgets[_id].amount;
        emit BudgetDisbursed(_id, budgets[_id].department, budgets[_id].amount);
    }

    /// @notice Verifikasi kebijakan pajak/anggaran oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("tax"))) {
            require(_id <= taxCount, "Tax policy tidak ada");
            taxPolicies[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("budget"))) {
            require(_id <= budgetCount, "Budget tidak ada");
            budgets[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
