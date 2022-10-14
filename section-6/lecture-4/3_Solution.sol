// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// Defining contract 
contract parent { 
 
    // Declaring internal
    // state variable 
    uint internal sum; 
       
    // Defining external function
    // to set value of internal
    // state variable sum
    function setValue() virtual external { 
        uint a = 10;
        uint b = 20;
        sum = a + b;
    } 
} 

// Defining child contract 
contract Solution is parent{ 
      
    function setValue() external override {
        uint a = 100;
        uint b = 200;
        sum = a + b;
    }

    // Defining external function
    // to return value of
    // internal state variable sum
    function getValue() external view returns(uint) { 
        return sum; 
    } 
}