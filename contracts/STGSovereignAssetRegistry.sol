// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Asset Registry Integration
/// @notice Membaca file JSON registry dari IPFS agar sinkron dengan dashboard treasury & explorer
contract STGSovereignAssetRegistry {
    address public governance;
    address public auditor;

    // Struktur metadata aset sesuai JSON Schema
    struct Asset {
        string asset_id;
        string category;
        string asset_name;
        uint256 value;
        string currency;
        string owner_wallet;
        string chain_network;
        string status;
        string hash_ipfs;
        uint256 timestamp;
        string auditor_validator;
    }

    mapping(string => Asset) public assets; // mapping asset_id → Asset
    string[] public assetIndex; // daftar ID aset

    event AssetRegistered(string asset_id, string category, string asset_name, uint256 value, string currency, string owner_wallet);
    event AssetVerified(string asset_id, string auditor);

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

    /// @notice Registrasi aset baru berdasarkan metadata JSON dari IPFS
    function registerAsset(
        string memory _asset_id,
        string memory _category,
        string memory _asset_name,
        uint256 _value,
        string memory _currency,
        string memory _owner_wallet,
        string memory _chain_network,
        string memory _status,
        string memory _hash_ipfs,
        uint256 _timestamp,
        string memory _auditor_validator
    ) external onlyGovernance {
        assets[_asset_id] = Asset({
            asset_id: _asset_id,
            category: _category,
            asset_name: _asset_name,
            value: _value,
            currency: _currency,
            owner_wallet: _owner_wallet,
            chain_network: _chain_network,
            status: _status,
            hash_ipfs: _hash_ipfs,
            timestamp: _timestamp,
            auditor_validator: _auditor_validator
        });
        assetIndex.push(_asset_id);
        emit AssetRegistered(_asset_id, _category, _asset_name, _value, _currency, _owner_wallet);
    }

    /// @notice Verifikasi aset oleh auditor eksternal
    function verifyAsset(string memory _asset_id) external onlyAuditor {
        require(bytes(assets[_asset_id].asset_id).length > 0, "Aset tidak ditemukan");
        assets[_asset_id].status = "Verified";
        emit AssetVerified(_asset_id, assets[_asset_id].auditor_validator);
    }

    /// @notice Ambil metadata aset untuk dashboard treasury
    function getAsset(string memory _asset_id) external view returns (Asset memory) {
        return assets[_asset_id];
    }

    /// @notice Ambil semua ID aset untuk explorer
    function getAllAssetIds() external view returns (string[] memory) {
        return assetIndex;
    }
}
