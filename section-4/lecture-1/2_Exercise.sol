// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/*
Update the “EtherWallet” contract from the lecture so that anyone can send and withdraw 
from the wallet. Rather than it being a single person Ether wallet, make it so that it is 
a wallet that can be used by multiple people. You will need to keep track of balances for 
each user using mapping. 
*/
contract Exercise {
    // Gonna let multiple users able to send and withdraw from the wallet
    // General Ether wallet
    // Implement the "deposit()" and "withdraw()" function
    // Implement the "balanceOf" to retrieve the current balance in the wallet

    // Todo: Keep track of multiple users and their balances

    // No constructor needed 

    // Todo: Update the deposit function to handle keeping track of multiple users and 
    // their balances
    function deposit() payable public {
    }

    // Todo: Add a new function to handle transferring the ETH between multiple users
    // within the smart contract wallet 
    function transfer(address payable receiver, uint amount) public {
    }

    // Todo: Update the withdraw function to handle the withdrawal from the smart contract
    // to the user wallet
    function withdraw(uint amount) public {
    }

    // Todo: Add a function to view the current balance for your own wallet
    function myBalance() view public returns(uint) {
        return wallets[msg.sender];
    }
}