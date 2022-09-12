// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    int public number;
    string public text;

    constructor(string memory _t, uint _n) {
        text = _t;
        number = int(_n);
    }
}