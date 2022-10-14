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
/*
    Create a child contract that inherits from the above parent contract 
    and overrides the function "setValue" whereby the value of a is 100,
    b is 200 so the sum of a + b would be 300. Also, implement a new 
    function called "getValue" that returns the value of sum
*/
contract Exercise { 
}
