// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title STG Sovereign Federalism Contract
/// @notice Integrasi hubungan pusat-daerah, otonomi digital, dan distribusi kewenangan
contract STGSovereignFederalism {
    address public governance;
    address public auditor;

    struct Region {
        uint256 id;
        string name;           // contoh: "West Java Digital Province"
        string autonomyLevel;  // contoh: "full", "partial", "limited"
        string powers;         // kewenangan: "taxation, local_law, resource_mgmt"
        string obligations;    // kewajiban: "reporting, ESG, treasury_sync"
        uint256 timestamp;
        bool verified;
    }

    mapping(uint256 => Region) public regions;
    uint256 public regionCount;

    event RegionRegistered(uint256 id, string name, string autonomyLevel, uint256 timestamp);
    event RegionUpdated(uint256 id, string autonomyLevel, string powers, string obligations);
    event RegionVerified(uint256 id, address auditor);

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

    /// @notice Registrasi daerah/region baru dengan otonomi digital
    function registerRegion(string memory _name, string memory _autonomyLevel, string memory _powers, string memory _obligations) external onlyGovernance {
        regionCount++;
        regions[regionCount] = Region({
            id: regionCount,
            name: _name,
            autonomyLevel: _autonomyLevel,
            powers: _powers,
            obligations: _obligations,
            timestamp: block.timestamp,
            verified: false
        });
        emit RegionRegistered(regionCount, _name, _autonomyLevel, block.timestamp);
    }

    /// @notice Update status otonomi dan kewenangan daerah
    function updateRegion(uint256 _id, string memory _autonomyLevel, string memory _powers, string memory _obligations) external onlyGovernance {
        require(_id <= regionCount, "Region tidak ada");
        regions[_id].autonomyLevel = _autonomyLevel;
        regions[_id].powers = _powers;
        regions[_id].obligations = _obligations;
        regions[_id].timestamp = block.timestamp;
        emit RegionUpdated(_id, _autonomyLevel, _powers, _obligations);
    }

    /// @notice Verifikasi daerah oleh auditor eksternal
    function verifyRegion(uint256 _id) external onlyAuditor {
        require(_id <= regionCount, "Region tidak ada");
        regions[_id].verified = true;
        emit RegionVerified(_id, msg.sender);
    }
}
