// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library MathLibrary {
    function multiply(uint a, uint b) public view returns (uint, address) {
        return (a * b, address(this));
    }
}

contract Solution {
    using MathLibrary for uint;

    address owner = address(this);

    function multiplyExample(uint _a, uint _b) public view returns (uint, address) {
        return _a.multiply(_b);
    }
}