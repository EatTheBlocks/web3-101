// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherWallet {
    // Gonna let one person(the deployer) able to send and withdraw from the wallet
    // Single person Ether wallet
    // Implement the "deposit()" and "withdraw()" function
    // Implement the "balanceOf" to retrieve the current balance in the wallet

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() payable public {
    }

    function withdraw(address payable receiver, uint amount) public {
        require(msg.sender == owner, "Only owner can withdraw the Ether");
        receiver.transfer(amount);
    }

    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }
}