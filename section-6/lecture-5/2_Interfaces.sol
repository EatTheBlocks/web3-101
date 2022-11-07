// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

interface Feline {
    function utterance() external pure returns (bytes32);

    function purr() external pure returns (bytes32);
}

contract Cat is Feline {
    function utterance() public pure returns (bytes32) {
        return "miaow";
    }

    function purr() public pure returns (bytes32) {
        return "purr purr purr";
    }
}
