// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/* 
    TODO: Create a library called "MathLibrary" that implements a function called
    "multiply" that multiples the two arguments being passed to the function 
    and returns two values:
    1) the result of that multiplication
    2) the address of the smart contract that's currently calling the library funciton 
*/

/*
    TODO: Declare the "using for" directive to be able to call the functions of MathLibrary
    for all the unsigned integer values. Then, implement a function called "multiplyExample"
    that takes in two arguments and calls the library function "multiply" and returns the two values:
    1) the result of the multiplication
    2) the address of this smart contract
*/
contract Exercise {
    address owner = address(this);

    function multiplyExample(uint _a, uint _b) public view returns (uint, address) {
    }
}