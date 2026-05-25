// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Data & Knowledge Contract
/// @notice Integrasi perpustakaan digital, manajemen data, dan akses pengetahuan on-chain
contract STGSovereignDataKnowledge {
    address public governance;
    address public auditor;

    struct DigitalLibrary {
        uint256 id;
        string title;          // contoh: "Blockchain Fundamentals"
        string contentHash;    // hash/IPFS konten digital
        string status;         // "submitted", "approved", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct DataRegistry {
        uint256 id;
        string datasetName;    // contoh: "Citizen Records"
        string description;
        string status;         // "registered", "updated", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct KnowledgeAccess {
        uint256 id;
        address requester;
        string resource;       // contoh: "Research Paper"
        string status;         // "granted", "revoked"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => DigitalLibrary) public libraries;
    mapping(uint256 => DataRegistry) public registries;
    mapping(uint256 => KnowledgeAccess) public accesses;

    uint256 public libraryCount;
    uint256 public registryCount;
    uint256 public accessCount;

    event LibrarySubmitted(uint256 id, string title, uint256 timestamp);
    event LibraryApproved(uint256 id, string title);
    event RegistryCreated(uint256 id, string datasetName, uint256 timestamp);
    event RegistryUpdated(uint256 id, string datasetName);
    event AccessGranted(uint256 id, address requester, string resource, uint256 timestamp);
    event AccessRevoked(uint256 id, address requester);
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

    /// @notice Ajukan konten perpustakaan digital
    function submitLibrary(string memory _title, string memory _contentHash) external {
        libraryCount++;
        libraries[libraryCount] = DigitalLibrary({
            id: libraryCount,
            title: _title,
            contentHash: _contentHash,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit LibrarySubmitted(libraryCount, _title, block.timestamp);
    }

    /// @notice Setujui konten perpustakaan digital
    function approveLibrary(uint256 _id) external onlyGovernance {
        require(_id <= libraryCount, "Library tidak ada");
        libraries[_id].status = "approved";
        emit LibraryApproved(_id, libraries[_id].title);
    }

    /// @notice Buat registrasi data baru
    function createRegistry(string memory _datasetName, string memory _description) external onlyGovernance {
        registryCount++;
        registries[registryCount] = DataRegistry({
            id: registryCount,
            datasetName: _datasetName,
            description: _description,
            status: "registered",
            timestamp: block.timestamp,
            verified: false
        });
        emit RegistryCreated(registryCount, _datasetName, block.timestamp);
    }

    /// @notice Update registrasi data
    function updateRegistry(uint256 _id, string memory _description) external onlyGovernance {
        require(_id <= registryCount, "Registry tidak ada");
        registries[_id].description = _description;
        registries[_id].status = "updated";
        emit RegistryUpdated(_id, registries[_id].datasetName);
    }

    /// @notice Berikan akses pengetahuan
    function grantAccess(address _requester, string memory _resource) external onlyGovernance {
        accessCount++;
        accesses[accessCount] = KnowledgeAccess({
            id: accessCount,
            requester: _requester,
            resource: _resource,
            status: "granted",
            timestamp: block.timestamp,
            verified: false
        });
        emit AccessGranted(accessCount, _requester, _resource, block.timestamp);
    }

    /// @notice Cabut akses pengetahuan
    function revokeAccess(uint256 _id) external onlyGovernance {
        require(_id <= accessCount, "Access tidak ada");
        accesses[_id].status = "revoked";
        emit AccessRevoked(_id, accesses[_id].requester);
    }

    /// @notice Verifikasi library/registry/access oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("library"))) {
            require(_id <= libraryCount, "Library tidak ada");
            libraries[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("registry"))) {
            require(_id <= registryCount, "Registry tidak ada");
            registries[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("access"))) {
            require(_id <= accessCount, "Access tidak ada");
            accesses[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}
