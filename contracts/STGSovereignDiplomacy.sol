// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Diplomacy Contract
/// @notice Integrasi hubungan internasional, perjanjian antar-chain, dan protokol diplomasi digital
contract STGSovereignDiplomacy {
    address public governance;
    address public auditor;

    struct Treaty {
        uint256 id;
        string partner;        // mitra diplomasi (chain/negara digital)
        string agreementHash;  // hash/IPFS dokumen perjanjian
        string status;         // "proposed", "ratified", "terminated"
        uint256 timestamp;
        bool verified;
    }

    struct Protocol {
        uint256 id;
        string name;           // contoh: "Cross-chain Security Pact"
        string description;    // detail protokol diplomasi
        string status;         // "active", "suspended"
        uint256 timestamp;
        bool verified;
    }

    struct Delegation {
        uint256 id;
        address delegate;
        string mission;        // contoh: "Trade Negotiation", "Peace Accord"
        string status;         // "assigned", "completed"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Treaty) public treaties;
    mapping(uint256 => Protocol) public protocols;
    mapping(uint256 => Delegation) public delegations;

    uint256 public treatyCount;
    uint256 public protocolCount;
    uint256 public delegationCount;

    event TreatyProposed(uint256 id, string partner, uint256 timestamp);
    event TreatyRatified(uint256 id, string partner);
    event TreatyTerminated(uint256 id, string partner);
    event ProtocolCreated(uint256 id, string name, uint256 timestamp);
    event ProtocolSuspended(uint256 id, string name);
    event DelegationAssigned(uint256 id, address delegate, string mission, uint256 timestamp);
    event DelegationCompleted(uint256 id, address delegate);
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

    /// @notice Ajukan perjanjian diplomasi baru
    function proposeTreaty(string memory _partner, string memory _agreementHash) external onlyGovernance {
        treatyCount++;
        treaties[treatyCount] = Treaty({
            id: treatyCount,
            partner: _partner,
            agreementHash: _agreementHash,
            status: "proposed",
            timestamp: block.timestamp,
            verified: false
        });
        emit TreatyProposed(treatyCount, _partner, block.timestamp);
    }

    /// @notice Ratifikasi perjanjian diplomasi
    function ratifyTreaty(uint256 _id) external onlyGovernance {
        require(_id <= treatyCount, "Treaty tidak ada");
        treaties[_id].status = "ratified";
        emit TreatyRatified(_id, treaties[_id].partner);
    }

    /// @notice Terminasi perjanjian diplomasi
    function terminateTreaty(uint256 _id) external onlyGovernance {
        require(_id <= treatyCount, "Treaty tidak ada");
        treaties[_id].status = "terminated";
        emit TreatyTerminated(_id, treaties[_id].partner);
    }

    /// @notice Buat protokol diplomasi digital
    function createProtocol(string memory _name, string memory _description) external onlyGovernance {
        protocolCount++;
        protocols[protocolCount] = Protocol({
            id: protocolCount,
            name: _name,
            description: _description,
            status: "active",
            timestamp: block.timestamp,
            verified: false
        });
        emit ProtocolCreated(protocolCount, _name, block.timestamp);
    }

    /// @notice Suspend protokol diplomasi
    function suspendProtocol(uint256 _id) external onlyGovernance {
        require(_id <= protocolCount, "Protocol tidak ada");
        protocols[_id].status = "suspended";
        emit ProtocolSuspended(_id, protocols[_id].name);
    }

    /// @notice Tugaskan delegasi diplomasi
    function assignDelegation(address _delegate, string memory _mission) external onlyGovernance {
        delegationCount++;
        delegations[delegationCount] = Delegation({
            id: delegationCount,
            delegate: _delegate,
            mission: _mission,
            status: "assigned",
            timestamp: block.timestamp,
            verified: false
        });
        emit DelegationAssigned(delegationCount, _delegate, _mission, block.timestamp);
    }

    /// @notice Tandai delegasi selesai
    function completeDelegation(uint256 _id) external onlyGovernance {
        require(_id <= delegationCount, "Delegation tidak ada");
        delegations[_id].status = "completed";
        emit DelegationCompleted(_id, delegations[_id].delegate);
    }

    /// @notice Verifikasi treaty/protokol/delegasi oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("treaty"))) {
            require(_id <= treatyCount, "Treaty tidak ada");
            treaties[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("protocol"))) {
            require(_id <= protocolCount, "Protocol tidak ada");
            protocols[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("delegation"))) {
            require(_id <= delegationCount, "Delegation tidak ada");
            delegations[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
