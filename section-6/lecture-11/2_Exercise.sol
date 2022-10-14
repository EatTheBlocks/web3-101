// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Account {
    address public bank;
    address public owner;

    constructor (address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

contract Exercise {
    // TODO: Create an array of accounts of type "Account"

    /*
        TODO: Create a function called "createAccount" that creates a new account
        and adds this account to the array of accounts above
    */
    function createAccount(address _owner) external payable {
    }

    // TODO: Get account info according to the address of the account
    function getAccountInfo(Account account) public view returns(address bank, address owner) {
    }
}