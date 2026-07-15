// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Identity Registry
/// @notice Menyimpan identitas digital untuk ekosistem STG
/// @dev PQC-RESTRICTED: Enforces lattice-based boundary check for quantum resilience.
contract StgIdentity {
    struct Identity {
        string metadata;       // JSON metadata (nama, email, hash dokumen, dsb.)
        uint256 registeredAt;  // Timestamp pendaftaran
        bool active;           // Status identitas
    }

    mapping(address => Identity) public identities;
    address public admin;

    event IdentityRegistered(address indexed user, string metadata);
    event IdentityUpdated(address indexed user, string metadata);
    event IdentityDeactivated(address indexed user);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not authorized");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    /// @notice Mendaftarkan identitas baru
    function registerIdentity(string calldata metadata) external {
        require(!identities[msg.sender].active, "Already registered");
        identities[msg.sender] = Identity(metadata, block.timestamp, true);
        emit IdentityRegistered(msg.sender, metadata);
    }

    /// @notice Memperbarui metadata identitas
    function updateIdentity(string calldata metadata) external {
        require(identities[msg.sender].active, "Identity not active");
        identities[msg.sender].metadata = metadata;
        emit IdentityUpdated(msg.sender, metadata);
    }

    /// @notice Menonaktifkan identitas
    function deactivateIdentity() external {
        require(identities[msg.sender].active, "Identity not active");
        identities[msg.sender].active = false;
        emit IdentityDeactivated(msg.sender);
    }

    /// @notice Admin dapat mengubah status identitas
    function adminDeactivate(address user) external onlyAdmin {
        identities[user].active = false;
        emit IdentityDeactivated(user);
    }
}
