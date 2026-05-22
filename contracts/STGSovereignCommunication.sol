// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Communication Contract
/// @notice Integrasi jaringan komunikasi, informasi publik, dan koordinasi darurat on-chain
contract STGSovereignCommunication {
    address public governance;
    address public auditor;

    struct Network {
        uint256 id;
        string name;           // contoh: "Quantum MeshNet", "Satellite Relay"
        string status;         // "active", "maintenance", "offline"
        uint256 timestamp;
        bool verified;
    }

    struct PublicInfo {
        uint256 id;
        string title;          // judul informasi publik
        string contentHash;    // hash/IPFS konten informasi
        string status;         // "submitted", "approved", "restricted"
        uint256 timestamp;
        bool verified;
    }

    struct EmergencyCoordination {
        uint256 id;
        string eventType;      // contoh: "Flood", "Cyber Attack"
        string actionPlan;     // contoh: "Evacuation", "System Lockdown"
        string status;         // "initiated", "executed", "resolved"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Network) public networks;
    mapping(uint256 => PublicInfo) public infos;
    mapping(uint256 => EmergencyCoordination) public emergencies;

    uint256 public networkCount;
    uint256 public infoCount;
    uint256 public emergencyCount;

    event NetworkRegistered(uint256 id, string name, string status, uint256 timestamp);
    event NetworkVerified(uint256 id, address auditor);
    event InfoSubmitted(uint256 id, string title, uint256 timestamp);
    event InfoApproved(uint256 id, string title);
    event EmergencyInitiated(uint256 id, string eventType, string actionPlan, uint256 timestamp);
    event EmergencyExecuted(uint256 id, string eventType);
    event EmergencyResolved(uint256 id, string eventType);

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

    /// @notice Registrasi jaringan komunikasi baru
    function registerNetwork(string memory _name, string memory _status) external onlyGovernance {
        networkCount++;
        networks[networkCount] = Network({
            id: networkCount,
            name: _name,
            status: _status,
            timestamp: block.timestamp,
            verified: false
        });
        emit NetworkRegistered(networkCount, _name, _status, block.timestamp);
    }

    /// @notice Verifikasi jaringan komunikasi
    function verifyNetwork(uint256 _id) external onlyAuditor {
        require(_id <= networkCount, "Network tidak ada");
        networks[_id].verified = true;
        emit NetworkVerified(_id, msg.sender);
    }

    /// @notice Ajukan informasi publik
    function submitInfo(string memory _title, string memory _contentHash) external {
        infoCount++;
        infos[infoCount] = PublicInfo({
            id: infoCount,
            title: _title,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit InfoSubmitted(infoCount, _title, block.timestamp);
    }

    /// @notice Setujui informasi publik
    function approveInfo(uint256 _id) external onlyGovernance {
        require(_id <= infoCount, "Info tidak ada");
        infos[_id].status = "approved";
        emit InfoApproved(_id, infos[_id].title);
    }

    /// @notice Inisiasi koordinasi darurat
    function initiateEmergency(string memory _eventType, string memory _actionPlan) external onlyGovernance {
        emergencyCount++;
        emergencies[emergencyCount] = EmergencyCoordination({
            id: emergencyCount,
            eventType: _eventType,
            actionPlan: _actionPlan,
            status: "initiated",
            timestamp: block.timestamp,
            verified: false
        });
        emit EmergencyInitiated(emergencyCount, _eventType, _actionPlan, block.timestamp);
    }

    /// @notice Eksekusi protokol darurat
    function executeEmergency(uint256 _id) external onlyGovernance {
        require(_id <= emergencyCount, "Emergency tidak ada");
        emergencies[_id].status = "executed";
        emit EmergencyExecuted(_id, emergencies[_id].eventType);
    }

    /// @notice Tandai darurat selesai
    function resolveEmergency(uint256 _id) external onlyGovernance {
        require(_id <= emergencyCount, "Emergency tidak ada");
        emergencies[_id].status = "resolved";
        emit EmergencyResolved(_id, emergencies[_id].eventType);
    }
}
