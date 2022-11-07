// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

library MathUtils {
    function add(uint a, uint b) public pure returns (uint) {
        return a + b;
    }
}

contract Calculator {
    function getSum(uint firstNumber, uint secondNumber)
        public
        pure
        returns (uint)
    {
        // Invoke and return the library function here ...
        return MathUtils.add(firstNumber, secondNumber);
    }
}
