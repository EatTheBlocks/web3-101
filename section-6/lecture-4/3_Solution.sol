// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

// Defining contract
contract parent {
    // Declaring internal
    // state variable
    uint internal sum;

    // Defining external function
    // to set value of internal
    // state variable sum
    function setValue() external virtual {
        uint a = 10;
        uint b = 20;
        sum = a + b;
    }
}

// Defining child contract
contract Solution is parent {
    function setValue() external override {
        uint a = 100;
        uint b = 200;
        sum = a + b;
    }

    // Defining external function
    // to return value of
    // internal state variable sum
    function getValue() external view returns (uint) {
        return sum;
    }
}
