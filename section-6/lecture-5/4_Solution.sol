// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

abstract contract SayHello {
    uint256 public age;

    constructor(uint256 _age) {
        age = _age;
    }

    function setAge(uint256 _age) public virtual {}

    function makeMeSayHello() public pure returns (string memory) {
        return "Hello";
    }
}

contract Solution is SayHello {
    string public name;

    constructor(string memory _name, uint256 _age) SayHello(_age) {
        name = _name;
    }

    function setName(string memory _name) public {
        name = _name;
    }

    function setAge(uint256 _age) public virtual override {
        age = _age;
    }
}
