// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.16;

contract Visibility {
    uint internal num1;
    uint num2; // This has internal visibility
    uint private num3;
    uint public num4;

    function getNums() external view returns (uint, uint) {
        return (num1, num2);
    }
}

contract NewContract is Visibility {
    function getNum() public view returns (uint, uint) {
        return this.getNums();
    }
}
