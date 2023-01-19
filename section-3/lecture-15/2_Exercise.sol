// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

/*
It is known that when you delete an item from the array, it creates a gap in the array. 
Create a function that removes an item in the array without creating any gap in the array.
*/
contract Exercise {
    /* It is known that when you delete an item from the array, it creates a gap in the array. 

    TODO: Create a function that removes an item in the array without creating any gap in the array.
    You do not need to check whether the index is out of bound for this exercise.

    This is what should happen:
    [1, 2, 3, 4] -- remove(1) --> [1, 3, 4]
    [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6] 
    */

    uint[] public arr;

    constructor(uint[] memory _arr) {
      arr = _arr;
    }

    function remove(uint index) public {
      // TODO: Your code goes here
    }

}
