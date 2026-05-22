// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Data & Knowledge Contract
/// @notice Integrasi perpustakaan digital, manajemen data, dan akses pengetahuan on-chain
contract STGSovereignDataKnowledge {
    address public governance;
    address public auditor;

    struct Library {
        uint256 id;
        string title;          // judul koleksi digital
        string contentHash;    // hash/IPFS konten
        string category;       // contoh: "Science", "Culture", "Law"
        string status;         // "submitted", "approved", "restricted"
        uint256 timestamp;
        bool verified;
    }

    struct DataRegistry {
        uint256 id;
        string datasetName;    // nama dataset
        string description;    // deskripsi dataset
        string status;         // "registered", "validated", "archived"
        uint256 timestamp;
        bool verified;
    }

    struct KnowledgeAccess {
        uint256 id;
        address requester;
        string resource;       // contoh: "Research Paper", "Historical Archive"
        string status;         // "requested", "granted", "denied"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Library) public libraries;
    mapping(uint256 => DataRegistry) public registries;
    mapping(uint256 => KnowledgeAccess) public accesses;

    uint256 public libraryCount;
    uint256 public registryCount;
    uint256 public accessCount;

    event LibrarySubmitted(uint256 id, string title, string category, uint256 timestamp);
    event LibraryApproved(uint256 id, string title);
    event DataRegistered(uint256 id, string datasetName, uint256 timestamp);
    event DataValidated(uint256 id, string datasetName);
    event AccessRequested(uint256 id, address requester, string resource, uint256 timestamp);
    event AccessGranted(uint256 id, address requester, string resource);
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

    /// @notice Ajukan koleksi perpustakaan digital
    function submitLibrary(string memory _title, string memory _contentHash, string memory _category) external {
        libraryCount++;
        libraries[libraryCount] = Library({
            id: libraryCount,
            title: _title,
            contentHash: _contentHash,
            category: _category,
            status: "submitted",
            timestamp: block.timestamp,
            verified: false
        });
        emit LibrarySubmitted(libraryCount, _title, _category, block.timestamp);
    }

    /// @notice Setujui koleksi perpustakaan digital
    function approveLibrary(uint256 _id) external onlyGovernance {
        require(_id <= libraryCount, "Library tidak ada");
        libraries[_id].status = "approved";
        emit LibraryApproved(_id, libraries[_id].title);
    }

    /// @notice Registrasi dataset baru
    function registerData(string memory _datasetName, string memory _description) external onlyGovernance {
        registryCount++;
        registries[registryCount] = DataRegistry({
            id: registryCount,
            datasetName: _datasetName,
            description: _description,
            status: "registered",
            timestamp: block.timestamp,
            verified: false
        });
        emit DataRegistered(registryCount, _datasetName, block.timestamp);
    }

    /// @notice Validasi dataset
    function validateData(uint256 _id) external onlyGovernance {
        require(_id <= registryCount, "Dataset tidak ada");
        registries[_id].status = "validated";
        emit DataValidated(_id, registries[_id].datasetName);
    }

    /// @notice Ajukan akses pengetahuan
    function requestAccess(string memory _resource) external {
        accessCount++;
        accesses[accessCount] = KnowledgeAccess({
            id: accessCount,
            requester: msg.sender,
            resource: _resource,
            status: "requested",
            timestamp: block.timestamp,
            verified: false
        });
        emit AccessRequested(accessCount, msg.sender, _resource, block.timestamp);
    }

    /// @notice Berikan akses pengetahuan
    function grantAccess(uint256 _id) external onlyGovernance {
        require(_id <= accessCount, "Access tidak ada");
        accesses[_id].status = "granted";
        emit AccessGranted(_id, accesses[_id].requester, accesses[_id].resource);
    }

    /// @notice Verifikasi library/data/access oleh auditor eksternal
    function verify(uint256 _id, string memory _category) external onlyAuditor {
        if (keccak256(bytes(_category)) == keccak256(bytes("library"))) {
            require(_id <= libraryCount, "Library tidak ada");
            libraries[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("data"))) {
            require(_id <= registryCount, "Dataset tidak ada");
            registries[_id].verified = true;
        } else if (keccak256(bytes(_category)) == keccak256(bytes("access"))) {
            require(_id <= accessCount, "Access tidak ada");
            accesses[_id].verified = true;
        }
        emit Verified(_id, _category, msg.sender);
    }
}


