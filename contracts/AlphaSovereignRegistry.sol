// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract STGSovereignRegistry is AccessControl, ReentrancyGuard, Pausable {
    bytes32 public constant COUNCIL_ROLE = keccak256("COUNCIL_ROLE");
    bytes32 public constant AUDITOR_ROLE = keccak256("AUDITOR_ROLE");

    uint public requiredApprovals;

    enum AssetStatus { Pending, Verified, Rejected, Frozen, Liquidated }

    struct Asset {
        bytes32 assetKey;
        string asset_id;
        string asset_name;
        uint256 value;
        bytes32 currency; // hemat gas
        AssetStatus status;
        string hash_ipfs; // CIDv1 pointer
        bytes32 metadataHash; // keccak256(metadataJSON)
    }

    struct StatusHistory {
        AssetStatus status;
        uint256 timestamp;
        address changedBy;
    }

    mapping(bytes32 => Asset) public assets;
    mapping(bytes32 => StatusHistory[]) public assetHistory;

    struct Proposal {
        bytes32 txHash;
        uint256 approvals;
        bool executed;
        mapping(address => bool) approvedBy;
    }

    mapping(bytes32 => Proposal) public proposals;

    event AssetRegistered(bytes32 assetKey, string asset_id, string asset_name, uint256 value, bytes32 currency, string hash_ipfs);
    event AssetStatusChanged(bytes32 assetKey, AssetStatus status, address changedBy);
    event AssetVerified(bytes32 assetKey, address auditor);

    constructor(uint _requiredApprovals) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        requiredApprovals = _requiredApprovals;
    }

    function _assetKey(string memory _asset_id) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked(_asset_id));
    }

    function registerAsset(
        string memory _asset_id,
        string memory _asset_name,
        uint256 _value,
        bytes32 _currency,
        string memory _hash_ipfs,
        bytes32 _metadataHash
    ) external whenNotPaused onlyRole(COUNCIL_ROLE) nonReentrant {
        bytes32 key = _assetKey(_asset_id);
        require(bytes(_hash_ipfs).length > 10, "CID invalid");

        assets[key] = Asset({
            assetKey: key,
            asset_id: _asset_id,
            asset_name: _asset_name,
            value: _value,
            currency: _currency,
            status: AssetStatus.Pending,
            hash_ipfs: _hash_ipfs,
            metadataHash: _metadataHash
        });

        assetHistory[key].push(StatusHistory({
            status: AssetStatus.Pending,
            timestamp: block.timestamp,
            changedBy: msg.sender
        }));

        emit AssetRegistered(key, _asset_id, _asset_name, _value, _currency, _hash_ipfs);
    }

    function verifyAsset(string memory _asset_id, bytes memory auditorSignature) external whenNotPaused onlyRole(AUDITOR_ROLE) {
        bytes32 key = _assetKey(_asset_id);
        require(bytes(assets[key].asset_id).length > 0, "Asset not found");

        assets[key].status = AssetStatus.Verified;
        assetHistory[key].push(StatusHistory({
            status: AssetStatus.Verified,
            timestamp: block.timestamp,
            changedBy: msg.sender
        }));

        emit AssetVerified(key, msg.sender);
    }

    function changeAssetStatus(string memory _asset_id, AssetStatus newStatus) external whenNotPaused onlyRole(COUNCIL_ROLE) {
        bytes32 key = _assetKey(_asset_id);
        require(bytes(assets[key].asset_id).length > 0, "Asset not found");

        assets[key].status = newStatus;
        assetHistory[key].push(StatusHistory({
            status: newStatus,
            timestamp: block.timestamp,
            changedBy: msg.sender
        }));

        emit AssetStatusChanged(key, newStatus, msg.sender);
    }

    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    function getAssetHistory(string memory _asset_id) external view returns (StatusHistory[] memory) {
        return assetHistory[_assetKey(_asset_id)];
    }
}
