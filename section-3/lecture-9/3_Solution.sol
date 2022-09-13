// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {
    function controlStructureFunc(uint x) public pure returns(uint) {
        if(x == 0) return 100;
        uint result = x;
        uint i = 0;
        while(i < 10) {
            result += result;
            i++;
        }
        return result;
    }
}