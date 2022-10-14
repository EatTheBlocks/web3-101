// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*
    TODO: Create an abstract contract called "SayHello" 
    that doesn't implement the "setAge" function
    (to set the state variable called "age")
    but does implement the "makeMeSayHello" function
    that just returns "Hello". The constructor should
    have one argument that is going to be used to set 
    the value of the state variable "age" upon deployment.
*/

/*
    TODO: Inherit from the "SayHello" abstract contract and 
    implement the function "setAge" that is inherited from
    the "SayHello" abstract contract. 
    The construcor should take in two arguments(name and age)
    that will then call the constructor of SayHello to set the age 
    state variable.
*/

contract Exercise {
    string public name;

    constructor(string memory _name, uint256  _age) {
       name = _name;
    }

    // TODO: Create a function "setAge" that overrides the function from "SayHello"
}
