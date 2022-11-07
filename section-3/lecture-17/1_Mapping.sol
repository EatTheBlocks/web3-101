// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.16;

contract MappingContract {
    // Regular map
    mapping(uint => address) public regularMap;
    // zero address: 0x0000000000000000000000000000000000000000
    // Nested map
    mapping(uint => mapping(uint => address)) public nestedMap;

    function getMappedValue(uint _i) public view returns (address, address) {
        // Mapping always returns a value
        // If the value was not set, it will return the default value
        return (regularMap[_i], nestedMap[_i][_i]);
    }

    function setMappedValue(uint _i, address _addr) public {
        regularMap[_i] = _addr;
        nestedMap[_i][_i] = _addr;
    }

    function removeMappedValue(uint _i) public {
        // This resets the value to the default value
        delete regularMap[_i];
        delete nestedMap[_i][_i];
    }
}
