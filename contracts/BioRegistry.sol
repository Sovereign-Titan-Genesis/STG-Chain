// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract STGBioRegistry {
    struct BioData {
        string pilarName;
        string dnaHash;
        uint256 timestamp;
    }

    mapping(string => BioData) public pilarRegistry;
    address public kapten;

    constructor() {
        kapten = msg.sender;
    }

    // Hanya Sultan (Kapten) yang bisa update
    modifier onlyKapten() {
        require(msg.sender == kapten, "Bukan akses Sultan!");
        _;
    }

    function updatePilar(string memory _pilar, string memory _dnaHash) public onlyKapten {
        pilarRegistry[_pilar] = BioData(_pilar, _dnaHash, block.timestamp);
    }
}
