// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.17;

contract parent {
    uint public num;

    function setValue(uint _value) public {
        num = _value;
    }

    function getValue() public view returns (uint) {
        return num;
    }
}

contract Solution {
    parent parentInstance;

    constructor(address _parent_address) {
        parentInstance = parent(_parent_address);
    }

    function getParentValue() public view returns (uint) {
        return parentInstance.getValue();
    }

    function setParentValue(uint _child_value) public {
        parentInstance.setValue(_child_value);
    }
}
