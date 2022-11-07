// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.16;

contract DataLocation {
    uint public age;
    uint[] ages;

    constructor() {
        age = 30;
    }

    // The data location of age2 is memory;
    function changeAge() public returns (uint) {
        uint age2 = age; // assign storage -> memory creates copy
        age = 20;
        return age2; // returns 30
    }

    function f(uint[] memory memoryArray)
        public
        returns (uint[] memory, uint[] memory)
    {
        ages = memoryArray; // works, copies the whole array to the storage
        uint[] storage y = ages; // works, assigns a pointer(reference), data location
        // of y is storage
        ages[0] = 2;
        return (y, ages);
    }
}
