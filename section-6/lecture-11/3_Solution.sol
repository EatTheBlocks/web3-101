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

contract Solution {
    Account[] public accounts;

    function createAccount(address _owner) external payable {
        Account account = new Account{value: msg.value}(_owner);
        accounts.push(account);
    }

    function getAccountInfo(Account account) public view returns(address bank, address owner) {
        return (account.bank(), account.owner());
    }
}