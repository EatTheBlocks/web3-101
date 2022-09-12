// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Visibility {
    uint internal num1;
    uint num2; // This has internal visibility
    uint private num3;
    uint public num4;

    function getNums() external view returns(uint, uint) {
        return (num1, num2);
    }
}

contract NewContract is Visibility {
    function getNum() public view returns(uint, uint) {
        return this.getNums();
    }
}