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
    // [1, 2, 3, 4] -- remove(1) --> [1, 4, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 6, 4, 5]

    uint[] public arr;

    constructor(uint[] memory _arr) {
        arr = _arr;
    }

    function remove(uint _index) public {
        // This is how you can check for index out of bound
        // require(_index < arr.length, "index out of bound");
        // or
        //
        if (_index > arr.length) {
            return;
        }
        for (uint i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
}
