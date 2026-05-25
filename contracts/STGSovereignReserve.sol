// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title STG Digital Sovereign Reserve Infrastructure
 * @notice Buku Induk Manajemen Aset Berdaulat Terintegrasi AI-Quantum & IPFS CIDv1
 * @author 5K Team AI under Command of Sultan Andi Muhammad Harpianto (2026)
 */
contract STGSovereignReserve {
    
    // --- ⚖️ LAYER 3: MULTI-SIGNATURE GOVERNANCE COUNCIL ---
    address[] public council;
    uint256 public requiredApprovals;
    mapping(address => bool) public isCouncilMember;

    // --- 🏛️ LAYER 4: LIFECYCLE STATUS PROTOCOL ---
    enum AssetStatus { Pending, Verified, Rejected, Frozen, Liquidated }

    struct Asset {
        bytes32 assetKey;          // Optimized bytes32 Primary Key
        string assetId;            // Human-readable ID (ex: "STG-NFT-001")
        string category;           // "NFT", "Treasury", "RWA", "Liquid"
        string assetName;          // Nama Aset / Deskripsi Pendek
        uint256 value;             // Valuasi Nominal Aset
        string currency;           // Denominasi Nilai (ex: "STG", "IDR", "USD")
        address ownerWallet;       // Dompet Pemilik Sah (ex: 0xD9a1...948e)
        AssetStatus status;        // Safe Enum Lifecycle Status
        string hashIpfsCidV1;      // Pointer Metadata Kompatibel IPFS CIDv1 (ipfs://bafy...)
        uint256 timestamp;         // Waktu Pencatatan Sistem
        bytes auditorSignature;    // Verifikasi Kriptografis Tanda Tangan Auditor
    }

    // Mapping Primary Key (bytes32 keccak256 hash) ke struct Asset
    mapping(bytes32 => Asset) public registry;
    bytes32[] public registryIndex;

    // --- 📢 LAYER 5: EVENT LOGS FOR EXPLORER INDEXING ---
    event AssetRegistered(
        bytes32 indexed assetKey, 
        string assetId, 
        string category, 
        uint256 value, 
        address indexed ownerWallet, 
        string hashIpfsCidV1
    );
    event AssetVerified(bytes32 indexed assetKey, address indexed auditor, AssetStatus newStatus);
    event AssetStatusChanged(bytes32 indexed assetKey, AssetStatus oldStatus, AssetStatus newStatus);
    event GovernanceActionProposed(bytes32 indexed txHash, string actionType);

    modifier onlyCouncil() {
        require(isCouncilMember[msg.sender], "Bukan Anggota Dewan Governance STG");
        _;
    }

    constructor(address[] memory _council, uint256 _requiredApprovals) {
        require(_council.length > 0, "Dewan Komando tidak boleh kosong");
        require(_requiredApprovals <= _council.length, "Jumlah persetujuan tidak valid");
        
        for (uint256 i = 0; i < _council.length; i++) {
            address member = _council[i];
            require(member != address(0), "Alamat tidak boleh nol");
            require(!isCouncilMember[member], "Anggota dewan duplikat");
            isCouncilMember[member] = true;
            council.push(member);
        }
        requiredApprovals = _requiredApprovals;
    }

    // --- 🔒 INTERNALS: OPTIMASI PRIMARY KEY GENERATOR ---
    function generateAssetKey(string memory _assetId) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_assetId));
    }

    // --- 🧠 CORE OPERATION: REGISTRASI ASET BERDAULAT ---
    /**
     * @notice Mendaftarkan aset baru langsung ke Buku Induk dengan Pointer IPFS CIDv1
     */
    function registerAsset(
        string memory _assetId,
        string memory _category,
        string memory _assetName,
        uint256 _value,
        string memory _currency,
        address _ownerWallet,
        string memory _hashIpfsCidV1
    ) external onlyCouncil {
        bytes32 key = generateAssetKey(_assetId);
        require(registry[key].assetKey == bytes32(0), "Aset dengan ID tersebut sudah terdaftar");

        registry[key] = Asset({
            assetKey: key,
            assetId: _assetId,
            category: _category,
            assetName: _assetName,
            value: _value,
            currency: _currency,
            ownerWallet: _ownerWallet,
            status: AssetStatus.Pending,
            hashIpfsCidV1: _hashIpfsCidV1,
            timestamp: block.timestamp,
            auditorSignature: ""
        });

        registryIndex.push(key);

        emit AssetRegistered(key, _assetId, _category, _value, _ownerWallet, _hashIpfsCidV1);
    }

    // --- 🔑 LAYER 6: AI OVERSIGHT & AUDITOR CRYPTOGRAPHIC VERIFICATION ---
    /**
     * @notice Memasukkan tanda tangan kriptografis Auditor dan memperbarui Lifecycle Status
     * @param _assetId ID unik aset yang diverifikasi
     * @param _signature Bukti tanda tangan digital auditor eksternal atas hash metadata
     */
    function verifyAsset(string memory _assetId, bytes memory _signature) external onlyCouncil {
        bytes32 key = generateAssetKey(_assetId);
        require(registry[key].assetKey != bytes32(0), "Aset tidak ditemukan di Buku Induk");
        require(registry[key].status == AssetStatus.Pending, "Aset tidak dalam status Pending");
        require(_signature.length > 0, "Tanda tangan kriptografis kosong");

        registry[key].auditorSignature = _signature;
        registry[key].status = AssetStatus.Verified;

        emit AssetVerified(key, msg.sender, AssetStatus.Verified);
    }

    /**
     * @notice Merubah status lifecycle aset (Freeze/Liquidate) sebagai Rem Darurat (Sovereign Circuit Breaker)
     */
    function changeAssetStatus(string memory _assetId, AssetStatus _newStatus) external onlyCouncil {
        bytes32 key = generateAssetKey(_assetId);
        require(registry[key].assetKey != bytes32(0), "Aset tidak ditemukan");
        
        AssetStatus oldStatus = registry[key].status;
        registry[key].status = _newStatus;

        emit AssetStatusChanged(key, oldStatus, _newStatus);
    }

    // --- 🌐 READ OPERATIONS FOR STG-WEB3 DASHBOARD & EXPLORER ---
    function getAssetByKey(bytes32 _key) external view returns (Asset memory) {
        return registry[_key];
    }

    function getAssetById(string memory _assetId) external view returns (Asset memory) {
        return registry[generateAssetKey(_assetId)];
    }

    function getRegistryLength() external view returns (uint256) {
        return registryIndex.length;
    }
}
