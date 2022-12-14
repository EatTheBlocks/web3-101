// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.16;

contract ArrayContract {
    // Dynamic arrays
    uint[] public dynamicArr1;
    uint[] public dynamicArr2 = [1, 2, 3];

    // Fixed array
    uint[10] public fixedArr;

    function get(uint i) public view returns (uint) {
        return dynamicArr1[i];
    }

    function getArr() public view returns (uint[] memory) {
        return dynamicArr1;
    }

    function push(uint i) public {
        // Append to array
        dynamicArr1.push(i);
    }

    function pop() public {
        dynamicArr1.pop();
    }

    function getLength() public view returns (uint) {
        return dynamicArr1.length;
    }

    function remove(uint i) public {
        delete dynamicArr1[i];
    }

    function createArrInMemory() external pure returns (uint[] memory) {
        uint[] memory fixedArr2 = new uint[](5);
        return fixedArr2;
    }
}
