// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    mapping(address => uint256) private wallets;

    function deposit() payable public {
        wallets[msg.sender] += msg.value;
    }

    function withdraw(address payable receiver, uint amount) public {
        require(wallets[msg.sender] >= amount, "Not enough money in the wallet");
        wallets[msg.sender] -= amount;
        wallets[receiver] += amount;
        receiver.transfer(amount);
    }

    function myBalance() view public returns(uint) {
        return wallets[msg.sender];
    }
}