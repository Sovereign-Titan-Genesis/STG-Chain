// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract STGFinance {
    mapping(address => uint256) private _balances;
    address public kapten;
    uint256 public totalSovereignWealth;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event SubsidyDistributed(address indexed to, uint256 value);

    constructor() {
        kapten = msg.sender;
        totalSovereignWealth = 1498 * 10**12; // Rp1.498 Triliun
        _balances[kapten] = totalSovereignWealth;
    }

    modifier onlyKapten() {
        require(msg.sender == kapten, "Akses ditolak: Hanya Sultan!");
        _;
    }

    function transfer(address to, uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Saldo Unit 008 tidak cukup");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }

    function distributeSubsidy(address targetWallet, uint256 amount) public onlyKapten {
        require(_balances[kapten] >= amount, "Dana pusat tidak cukup");
        _balances[kapten] -= amount;
        _balances[targetWallet] += amount;
        emit SubsidyDistributed(targetWallet, amount);
    }

    function checkBalance(address account) public view returns (uint256) {
        return _balances[account];
    }
}
