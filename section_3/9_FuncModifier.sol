// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract FuncModifier {
    address owner;
    uint public result;

    constructor() {
        owner = msg.sender;
    }

    function setResult() external onlyOwner {
        result = 10;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

}