// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/*
Find a way to declare two variables of the same name(one state variable and
another local variable) and set the value of local variable to whatever
the value of the state variable is and return the value;
*/
contract Exercise {
    uint public data = 30;
   
    /*  
        Note: You may get the warning "This declaration shadows an existing declaration"
        This is ok for this exercise but you probably won't do this in real life.
    */

    function scoping() public returns(uint) {
        // TODO
    }
}
