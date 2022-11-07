// SPDX-License-Identifier: MIT
/*
    WARNING: Please note that this contract has not been audited and as such may not be feasible 
    to deploy to the mainnet as is. The contract acts only as an example to showcase how to develop
    smart contracts in Solidity. It may contain vulnerabilities that are unaccounted for and as such,
    should not be used in real environment. Do your own diligence before deploying any smart contracts
    to the blockchain because once deployed, you cannot modify the contract.
*/
pragma solidity ^0.8.16;

contract Functions {
    uint public result;
    address payable owner;

    function getResult() public payable returns (uint) {
        uint a = 1; //local variable
        result = squareOfNumber(result) + a;
        return result;
    }

    function getResult(uint a) public payable returns (uint) {
        result = squareOfNumber(result) + a;
        return result;
    }

    function squareOfNumber(uint x) public pure returns (uint) {
        return x * x;
    }

    // view
    // pure
    // payable
    // msg.sender
    // block.timestamp

    /*
    Special Functions
    */
    receive() external payable {}

    fallback() external payable {}

    function transfer(uint256 amount) public virtual returns (bool) {
        getResult(amount);
        return true;
    }
}

contract FunctionsTwo is Functions {
    function transfer(uint256 amount) public virtual override returns (bool) {
        getResult(amount);
        return false;
    }
}
