// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract EtherWallet {
    // Gonna let one person(the deployer) able to send and withdraw from the wallet
    // Single person Ether wallet
    // Implement the "deposit()" and "withdraw()" function
    // Implement the "balanceOf" to retrieve the current balance in the wallet

    address payable public owner;

    constructor(address payable _owner) {
        owner = _owner;
    }

    function deposit() payable public {
    }

    function withdraw(address payable receiver, uint amount) public {
        require(msg.sender == owner, "Only owner can withdraw the Ether");
        receiver.transfer(amount);
        /*
        if(msg.sender == owner) {
         // logic
            receiver.transfer(amount);
            return;
        } else {
            revert('Only owner can withdraw the Ether');
        }
        */
    }

    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }
}