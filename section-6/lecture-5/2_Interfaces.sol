// SPDX-License-Identifier: MIT
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
