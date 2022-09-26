// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EtherWallet {
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