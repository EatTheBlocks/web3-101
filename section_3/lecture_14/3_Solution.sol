// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

contract Solution {

    function func1(uint[] memory arr1) public pure returns (uint[] memory) {
        // do something with memory array
        return arr1;
    }

    function func2(uint[] calldata arr2) external pure returns(uint[]memory) {
        // do something with calldata array
        return arr2;
    }
}