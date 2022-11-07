// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

library MathLibrary {
    function multiply(uint a, uint b) public view returns (uint, address) {
        return (a * b, address(this));
    }
}

contract Solution {
    using MathLibrary for uint;

    address owner = address(this);

    function multiplyExample(uint _a, uint _b)
        public
        view
        returns (uint, address)
    {
        return _a.multiply(_b);
    }
}
