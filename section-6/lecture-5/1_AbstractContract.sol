// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Feline {
    function utterance() public pure virtual returns (bytes32);

    function purr() public pure virtual returns (bytes32) {
        return "purr purr purr";
    }
}

contract Cat is Feline {
    function utterance() public pure override returns (bytes32) {
        return "miaow";
    }
}
