// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Citizenship Contract
/// @notice Integrasi hak, kewajiban, dan status warga STG ke dalam governance on-chain
contract STGSovereignCitizenship {
    address public governance;
    address public auditor;

    struct Citizen {
        uint256 id;
        address wallet;
        string status;        // contoh: "active", "suspended", "revoked"
        string rights;        // hak: "vote, propose, access_treasury"
        string duties;        // kewajiban: "pay_tax, uphold_ESG, validate_identity"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Citizen) public citizens;
    uint256 public citizenCount;

    event CitizenRegistered(uint256 id, address wallet, string rights, string duties, uint256 timestamp);
    event CitizenUpdated(uint256 id, string status, string rights, string duties);
    event CitizenVerified(uint256 id, address auditor);

    modifier onlyGovernance() {
        require(msg.sender == governance, "Hanya governance");
        _;
    }

    modifier onlyAuditor() {
        require(msg.sender == auditor, "Hanya auditor");
        _;
    }

    constructor(address _governance, address _auditor) {
        governance = _governance;
        auditor = _auditor;
    }

    /// @notice Registrasi warga baru STG
    function registerCitizen(address _wallet, string memory _rights, string memory _duties) external onlyGovernance {
        citizenCount++;
        citizens[citizenCount] = Citizen({
            id: citizenCount,
            wallet: _wallet,
            status: "active",
            rights: _rights,
            duties: _duties,
            timestamp: block.timestamp,
            verified: false
        });
        emit CitizenRegistered(citizenCount, _wallet, _rights, _duties, block.timestamp);
    }

    /// @notice Update status, hak, dan kewajiban warga
    function updateCitizen(uint256 _id, string memory _status, string memory _rights, string memory _duties) external onlyGovernance {
        require(_id <= citizenCount, "Citizen tidak ada");
        citizens[_id].status = _status;
        citizens[_id].rights = _rights;
        citizens[_id].duties = _duties;
        citizens[_id].timestamp = block.timestamp;
        emit CitizenUpdated(_id, _status, _rights, _duties);
    }

    /// @notice Verifikasi warga oleh auditor eksternal
    function verifyCitizen(uint256 _id) external onlyAuditor {
        require(_id <= citizenCount, "Citizen tidak ada");
        citizens[_id].verified = true;
        emit CitizenVerified(_id, msg.sender);
    }
}
