// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Functions {
    uint public result;
    address payable owner;

    function getResult() public payable returns(uint) {
        uint a = 1; //local variable
        result = squareOfNumber(result) + a;
        return result;
    }

    function getResult(uint a) public payable returns(uint) {
        result = squareOfNumber(result) + a;
        return result;
    }

    function squareOfNumber(uint x) public pure returns(uint) {
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
    receive() external payable {

    }

    fallback() external payable {

    }

    function transfer(uint256 amount) public virtual returns(bool) {
        getResult(amount);
        return true;
    }
}

contract FunctionsTwo is Functions {

    function transfer(uint256 amount) public virtual override returns(bool) {
        getResult(amount);
        return false;
    }

}