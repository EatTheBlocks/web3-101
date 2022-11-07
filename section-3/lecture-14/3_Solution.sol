// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/

pragma solidity ^0.8.16;

contract Solution {
    function func1(uint[] memory arr1) public pure returns (uint[] memory) {
        // do something with memory array
        return arr1;
    }

    function func2(uint[] calldata arr2) external pure returns (uint[] memory) {
        // do something with calldata array
        return arr2;
    }
}
