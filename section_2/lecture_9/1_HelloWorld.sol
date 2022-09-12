// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract HelloWorld {
    string public text;

    constructor() {}

    function setText() public {
        text = "Hello World";
    }

    function getText() public view returns(string memory) {
        return text;
    }
}

