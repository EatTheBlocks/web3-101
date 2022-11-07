// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/

pragma solidity ^0.8.16;

contract Solution {
    mapping(address => uint256) private wallets;

    function deposit() public payable {
        wallets[msg.sender] += msg.value;
    }

    function transfer(address payable receiver, uint amount) public {
        require(
            wallets[msg.sender] >= amount,
            "Not enough money in the wallet"
        );
        wallets[msg.sender] -= amount;
        wallets[receiver] += amount;
    }

    function withdraw(uint amount) public {
        address payable receiver = payable(msg.sender);
        require(
            wallets[msg.sender] >= amount,
            "Not enough money in the wallet"
        );
        wallets[msg.sender] -= amount;
        receiver.transfer(amount);
    }

    function myBalance() public view returns (uint) {
        return wallets[msg.sender];
    }
}
