// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Economic Contract
/// @notice Integrasi perdagangan digital, pasar on-chain, dan sistem ekonomi berdaulat
contract STGSovereignEconomic {
    address public governance;
    address public auditor;

    struct Trade {
        uint256 id;
        address seller;
        address buyer;
        string item;           // contoh: "Digital Batik NFT"
        uint256 price;         // harga dalam token STG
        string status;         // "initiated", "completed", "cancelled"
        uint256 timestamp;
        bool verified;
    }

    struct Market {
        uint256 id;
        string name;           // contoh: "STG Marketplace"
        string category;       // contoh: "Art", "Finance", "Agriculture"
        string status;         // "active", "suspended"
        uint256 timestamp;
        bool verified;
    }

    struct EconomicPolicy {
        uint256 id;
        string title;          // contoh: "Digital Trade Tariff"
        string description;
        string status;         // "proposed", "approved", "executed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Trade) public trades;
    mapping(uint256 => Market) public markets;
    mapping(uint256 => EconomicPolicy) public policies;

    uint256 public tradeCount;
    uint256 public marketCount;
    uint256 public policyCount;

    event TradeInitiated(uint256 id, address seller, address buyer, string item, uint256 price, uint256 timestamp);
    event TradeCompleted(uint256 id, string item);
    event MarketCreated(uint256 id, string name, string category, uint256 timestamp);
    event MarketSuspended(uint256 id, string name);
    event PolicyProposed(uint256 id, string title, uint256 timestamp);
    event PolicyExecuted(uint256 id, string title);
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

    /// @notice Inisiasi perdagangan digital
    function initiateTrade(address _seller, address _buyer, string memory _item, uint256 _price) external onlyGovernance {
        tradeCount++;
        trades[tradeCount] = Trade({
            id: tradeCount,
            seller: _seller,
            buyer: _buyer,
            item: _item,
            price: _price,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit TradeInitiated(tradeCount, _seller, _buyer, _item, _price, block.timestamp);
    }

    /// @notice Tandai perdagangan selesai
    function completeTrade(uint256 _id) external onlyGovernance {
        require(_id <= tradeCount, "Trade tidak ada");
        trades[_id].status = "completed";
        emit TradeCompleted(_id, trades[_id].item);
    }

    /// @notice Buat pasar on-chain baru
    function createMarket(string memory _name, string memory _category) external onlyGovernance {
        marketCount++;
        markets[marketCount] = Market({
            id: marketCount,
            name: _name,
            category: _category,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit MarketCreated(marketCount, _name, _category, block.timestamp);
    }

    /// @notice Suspend pasar on-chain
    function suspendMarket(uint256 _id) external onlyGovernance {
        require(_id <= marketCount, "Market tidak ada");
        markets[_id].status = "suspended";
        emit MarketSuspended(_id, markets[_id].name);
    }

    /// @notice Ajukan kebijakan ekonomi
    function proposePolicy(string memory _title, string memory _description) external onlyGovernance {
        policyCount++;
        policies[policyCount] = EconomicPolicy({
            id: policyCount,
            title: _title,
            description: _description,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit PolicyProposed(policyCount, _title, block.timestamp);
    }

    /// @notice Eksekusi kebijakan ekonomi
    function executePolicy(uint256 _id) external onlyGovernance {
        require(_id <= policyCount, "Policy tidak ada");
        policies[_id].status = "executed";
        emit PolicyExecuted(_id, policies[_id].title);
    }

    /// @notice Verifikasi trade/market/policy oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("trade"))) {
            require(_id <= tradeCount, "Trade tidak ada");
            trades[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("market"))) {
            require(_id <= marketCount, "Market tidak ada");
            markets[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("policy"))) {
            require(_id <= policyCount, "Policy tidak ada");
            policies[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
