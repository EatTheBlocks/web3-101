// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    uint public data = 30;

    function scoping() public view returns(uint) {
        uint data = data;
        return data;
    }
}